# Desenvolvimento

## Pré-requisitos

- Xcode com suporte a Swift 6 toolchain (swift-tools-version 6.0 declarado em `Package.swift`; código-fonte usa `.swiftLanguageMode(.v5)`).
- iOS 15+ como target mínimo.
- CocoaPods instalado (`gem install cocoapods`) apenas se for testar o fluxo legado via Pods.

## Editar o SDK

Abra `src/BlipChat.xcodeproj` para navegar/editar os fontes diretamente, **ou** abra `Package.swift` na raiz como um pacote Swift no Xcode (`File > Open`). Não existe um app "runner" dentro de `src/` — para ver o SDK funcionando de fato, use um dos samples.

## Rodar/testar via sample Swift (SPM local ou CocoaPods local)

```sh
cd samples/blip-sdk-webview-swift
open blip-sdk-webview.xcworkspace   # NÃO abrir o .xcodeproj — CocoaPods requer o .xcworkspace
```

O `Podfile` do sample já aponta para os fontes locais (`pod 'BlipChat', :path => '../..'`), então qualquer alteração em `src/BlipChat/` é refletida ao rodar `pod install` novamente e rebuildar — não é necessário publicar uma versão para testar mudanças.

## Rodar/testar via sample Objective-C

Mesmo fluxo em `samples/blip-sdk-webview-objective-c/`.

## Build/lint automatizado

Não há scripts de build, lint ou CI configurados neste repositório (sem `Fastfile`, sem `.github/workflows`, sem pipeline YAML na raiz). A validação de build é feita manualmente pelo Xcode ao abrir os samples ou o pacote SPM.

## Publicação de nova versão (processo manual observado)

1. Atualizar `s.version` em `src/BlipChat.podspec`.
2. Commitar (`chore: bump version to X.Y.Z`).
3. Criar tag git `X.Y.Z`.
4. `pod trunk push src/BlipChat.podspec` (CocoaPods) — não confirmado neste bootstrap se é executado localmente ou por outro processo; ver [decisions.md](decisions.md) (Unknown).
5. SPM não requer publicação adicional: consumidores apontam para a tag do repositório GitHub diretamente.
