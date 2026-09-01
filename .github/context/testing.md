# Testes

## Estado real: não há testes automatizados do SDK

- `src/BlipChat.xcodeproj` **não define nenhum target de teste** para o SDK em si.
- Os únicos alvos de teste do repositório vivem dentro de `samples/*/**Tests` e `**UITests`, e contêm apenas o boilerplate padrão gerado pelo template Xcode (`testExample`, `testPerformanceExample`), sem asserções reais sobre `BlipClient`, `BlipOptions` ou o carregamento da WebView.
- Não há testes de snapshot, testes de UI reais, nem testes de integração com o `blip-chat-widget`.

## Como validar mudanças hoje (na prática)

Validação é manual, via os samples:

1. Alterar código em `src/BlipChat/`.
2. Rodar `pod install` (ou abrir o pacote SPM) em um dos samples, que consome os fontes locais via `:path => '../..'`.
3. Rodar o app no simulador/dispositivo e verificar visualmente:
   - abertura do chat via `openBlipThread` (push de navegação);
   - abertura via `getBlipThreadViewController` (embutido como child VC);
   - autenticação Guest e Dev;
   - comportamento de teclado (o WebView precisa ajustar constraints e avisar o widget JS via `setKeyboardOpen`);
   - rotação de tela.

## Implicação para quem for propor mudanças

Qualquer PR que altere `BlipClient`, `BlipOptions`, `ThreadViewController` ou `BlipSdkTemplate.html` não tem rede de segurança automatizada — revisão de código e teste manual nos dois samples (Swift e Objective-C) é a única forma de detectar regressão antes do release.
