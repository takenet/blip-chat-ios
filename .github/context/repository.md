# Estrutura do repositório

```text
blip-chat-ios/
├── BlipChat.podspec        # symlink/cópia — CocoaPods lê do root; fonte real está em src/BlipChat.podspec
├── Package.swift           # manifesto SPM (swift-tools-version 6.0, plataforma iOS 15)
├── README.md                # única documentação pública; guia de instalação e uso completo
├── LICENSE                  # Apache 2.0
├── images/                  # screenshots usados no README
├── Releases/                # .zips históricos de versões antigas (formato de distribuição pré-SPM)
├── src/
│   ├── BlipChat.podspec     # podspec "fonte da verdade"
│   ├── BlipChat.xcodeproj/  # projeto Xcode apenas para abrir/editar os fontes (não define target de testes)
│   └── BlipChat/            # todo o código-fonte do SDK (ver architecture.md)
└── samples/                 # apps de exemplo, cada um com seu próprio Podfile/xcodeproj/testes
    ├── blip-sdk-webview-swift/         # sample em Swift, consome o pod via path (`pod 'BlipChat', :path => '../..'`)
    └── blip-sdk-webview-objective-c/   # sample em Objective-C, mesma estratégia
```

## Branches e versionamento

- `master` — branch principal de desenvolvimento.
- `release/*` (ex.: `release/340`) — branches de release; o HEAD observado neste bootstrap está em `release/340`, tag `3.4.0`.
- Sem CI/CD configurado neste repositório: **não há pasta `.github/workflows`** nem pipeline YAML na raiz. Publicação (CocoaPods trunk / tag SPM) é manual.
- Tags seguem SemVer puro (`x.y.z`, com sufixos `-beta1`/`-beta2` já usados no passado). Histórico de tags vai de `0.0.12` até `3.4.0`.
- Convenção de commit observada no histórico: prefixos estilo Conventional Commits (`feat:`, `fix:`, `chore:`) já em uso, mas não graças a Semantic Release automatizado — os bumps de versão são commits manuais (`chore: bump version to X.Y.Z`).

## Versionamento em múltiplos lugares (atenção ao editar)

Ao lançar uma nova versão, os seguintes locais precisam ser mantidos em sincronia manualmente (não há automação):

1. `src/BlipChat.podspec` → `s.version`
2. Tag git (`vX.Y.Z` ou `X.Y.Z`)
3. `README.md` → texto de exemplo "Up to Next Major from X.Y.Z"
4. Sample Podfiles referenciam a versão publicada como comentário (`# pod 'BlipChat', 'X.Y.Z'`) — hoje usam `:path => '../..'` para testar contra os fontes locais.

Ver [decisions.md](decisions.md) para o desalinhamento atual detectado entre podspec e tags.

## Samples

Cada sample em `samples/` é um app iOS completo e independente (seu próprio `Podfile`, `.xcodeproj`, `.xcworkspace`, alvo de testes unitários e UI). Servem como:

- Documentação viva de integração (Swift e Objective-C).
- Ambiente de smoke test manual antes de releases (não há testes automatizados reais, ver [testing.md](testing.md)).

Os testes dentro dos samples (`*Tests/`, `*UITests/`) são o template padrão gerado pelo Xcode (`testExample`, `testPerformanceExample`), sem asserções reais.
