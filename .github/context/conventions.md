# Convenções

## Compatibilidade dupla Swift/Objective-C

Toda API pública destinada a consumidores externos é marcada `@objc` e herda de `NSObject` (`BlipClient`, `BlipOptions`, `AuthConfig`, `Account`, `ConnectionDataConfig`). Isso é obrigatório para manter a SDK utilizável a partir de Objective-C (ver seção "How to use" do [README](../../README.md), que documenta ambas as linguagens lado a lado).

Regra prática: **qualquer novo membro de API pública deve ser `@objc`-compatível** (sem generics, sem enums Swift puros sem `Int` raw value, sem `Optional` de tipos não-objc) para não quebrar o uso via Objective-C.

## Múltiplos inicializadores em vez de parâmetros default em `@objc`

`BlipOptions` expõe vários `init` sobrecarregados (em vez de parâmetros com valor default) porque **inicializadores `@objc` não suportam argument defaults** — Objective-C não teria como omitir parâmetros. Ao adicionar uma nova opção configurável, siga esse padrão: crie um novo `init` que aceita o superconjunto de parâmetros, mantendo os inicializadores antigos intactos para não quebrar consumidores existentes.

## Internal vs public

Classes que não fazem parte do contrato do SDK (`ThreadViewController`, `BlipWebViewBuilder`, `Constants`) são `internal`, não `@objc public`. Mantenha esse limite: novos detalhes de implementação não devem vazar como público.

## Erros

Erros de uso incorreto da API são modelados como `enum BlipErrors: LocalizedError` (ver `BlipErrors.swift`) e lançados (`throws`), nunca por `fatalError`/`assert` em caminho de API pública. `assertionFailure` é usado apenas para falhas de recurso interno irrecuperável (ex.: `BlipSdkTemplate.html` ausente do bundle).

## Placeholders do template HTML

Ao adicionar uma nova opção de configuração que precise chegar ao JS (`blip-chat-widget`), o padrão é:

1. Adicionar a propriedade em `BlipOptions` (com getter interno tipo `getXxx() -> String` que serializa para JSON).
2. Adicionar uma constante de placeholder em `Constants.swift` (`%novoValor%`).
3. Adicionar o placeholder em `BlipSdkTemplate.html`.
4. Substituir o placeholder em `ThreadViewController.viewDidLoad()`.

## Versionamento semântico do produto

Apesar de não haver Semantic Release automatizado configurado neste repositório (diferente de outros repositórios BLiP), siga Conventional Commits nas mensagens (`feat:`, `fix:`, `chore:`) — é a convenção já observada no histórico e esperada pela instrução organizacional de padronização de commits/PRs.
