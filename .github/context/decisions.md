# Decisões técnicas e riscos estruturais conhecidos

## Decisão: UI do chat vive em JavaScript, não em Swift

O SDK iOS delibera não reimplementar a UI/lógica de chat nativamente. Em vez disso, hospeda uma `WKWebView` que carrega o `blip-chat-widget` (JS) publicado em `unpkg.com/blip-chat-widget`. Vantagem: paridade de comportamento entre plataformas (web/iOS/Android) mantendo uma única fonte de UI. Custo: o SDK iOS depende de conectividade externa a `unpkg.com` e `chat.blip.ai` em runtime — não funciona totalmente offline, e mudanças/quebras no `blip-chat-widget` publicado afetam este SDK sem precisar de nova versão do SDK iOS.

## Decisão: distribuição dual SPM (atual) / CocoaPods (legado)

SPM é o caminho recomendado desde a tag `3.3.0` (`afbb20f feat: publish SDK in Swift Package Manager`). CocoaPods é mantido por compatibilidade com integrações antigas. Isso obriga o código a ramificar (`#if SWIFT_PACKAGE`) no acesso a bundle de recursos — ver [architecture.md](architecture.md).

## Risco/Unknown: podspec desalinhado com a tag mais recente

`src/BlipChat.podspec` declara `s.version = "3.1.1"`, mas a tag mais recente no git é `3.4.0` (branch `release/340`, HEAD atual). Também o campo `s.source` do podspec ainda aponta para `Releases/2.2.5-beta2.zip`, um artefato bem antigo, pré-migração para SPM.

Isso é um **fato desatualizado potencialmente intencional ou um esquecimento** — não documentar como certeza. Hipóteses:

- O fluxo CocoaPods pode estar efetivamente congelado/deprecado na prática (README já o rotula como "legacy"), e o podspec só não foi atualizado porque publicações recentes usam somente SPM.
- Ou é um bug de processo de release (podspec esquecido no bump de versão).

**Recomendação**: antes de publicar qualquer nova versão via CocoaPods, confirmar se `s.version`/`s.source` do podspec precisam ser atualizados, ou se o suporte a CocoaPods deve ser formalmente descontinuado (e documentado como tal no README).

## Risco: ausência de testes automatizados

Ver [testing.md](testing.md). Qualquer regressão em `ThreadViewController`/`BlipClient`/template HTML só é pega manualmente.

## Risco: ausência de CI/CD

Não há `.github/workflows` nem pipeline YAML neste repositório. Build, teste manual e publicação de release dependem inteiramente de execução manual por um mantenedor.

## Dependência externa não versionada explicitamente

A versão do `blip-chat-widget` JS carregada é sempre a mais recente publicada em `unpkg.com/blip-chat-widget` (sem pin de versão no template HTML), a menos que o integrador informe `customWidgetUrl` em `BlipOptions`. Isso significa que o comportamento do chat pode mudar para todos os apps que usam este SDK sem que o SDK iOS mude — acoplamento implícito com o release do widget web.

## Unknown: processo real de publicação em CocoaPods trunk

Não foi encontrada automação (script, Fastlane, workflow) que execute `pod trunk push`. Presume-se processo manual por um mantenedor com credenciais de trunk, mas isso não foi confirmado dentro do repositório.

## Discovery Energisa (branch `feat/blip-chat-evolution-energisa`)

Achados registrados aqui para que sessões futuras não reinvestiguem os mesmos itens do zero.

### E1 — Captura de foto nativa: nenhuma mudança de código necessária neste SDK

**Decisão (commit `12b3c47`, apenas `README.md`)**: o item E1 do discovery Energisa (captura de foto nativa a partir do chat) **não requer implementação Swift** neste SDK. `WKWebView` já suporta nativamente o seletor de arquivo/câmera do input HTML (`<input type="file" capture>`) usado pelo `blip-chat-widget`, sem necessidade de `runOpenPanel`/`UIImagePickerController`/`PHPickerViewController` próprios — confirmado por Architect: nenhuma dessas implementações existe ou é necessária neste repositório (ver [architecture.md](architecture.md), tabela de componentes — `ThreadViewController`/`BlipWebViewBuilder` não implementam delegate de upload de arquivo customizado).

**Responsabilidade transferida para o app consumidor**: as chaves de privacidade `NSCameraUsageDescription` e `NSPhotoLibraryUsageDescription` devem ser declaradas no `Info.plist` do **app que integra o SDK**, não no SDK. Isso foi documentado no `README.md` (seção de permissões, junto com o padrão já existente para `NSLocationWhenInUseUsageDescription`).

**Fato observado (comportamento do SO)**: se essas chaves estiverem ausentes, o iOS não bloqueia silenciosamente a permissão — ele **encerra o processo do app** ao tentar abrir a câmera/seletor (enforcement de privacidade/TCC do próprio iOS). Isso não é um bug do SDK.

**Incerteza conhecida (apontada por Reviewer independente, `APPROVED_WITH_NOTES`, não validada em dispositivo real)**: a afirmação de que a ausência específica de `NSPhotoLibraryUsageDescription` (e não só `NSCameraUsageDescription`) causa esse crash é uma **inferência razoável, não um fato confirmado** para o caso da galeria via seletor nativo do WebKit. Desde iOS 14, esse seletor pode usar `PHPickerViewController`, que **não exige** `NSPhotoLibraryUsageDescription` (o picker roda fora do sandbox do app, sem acesso direto à galeria). Ou seja, é possível que apenas `NSCameraUsageDescription` seja estritamente necessária, e a exigência de `NSPhotoLibraryUsageDescription` dependa de qual API o `blip-chat-widget`/WebKit efetivamente aciona em runtime. **Não tratar isso como confirmado até validação em dispositivo real.**

### F7 — Ajuste de teclado: já implementado, `NO_ACTION_REQUIRED`

O mecanismo de ajuste de layout ao abrir/fechar o teclado **já existe e funciona** neste SDK, equivalente ao comportamento do Android. Fluxo (ver [architecture.md](architecture.md)):

`ThreadViewController` observa `UIKeyboardWillShow`/`UIKeyboardWillHide` → ajusta a constraint inferior da `WKWebView` → chama `evaluateJavaScript("setKeyboardOpen(...)")` → o `BlipSdkTemplate.html`/`blip-chat-widget` reage e envia `postMessage({code: 'KeyboardState'})` de volta.

Nenhuma ação de código é necessária para este item no discovery Energisa.
