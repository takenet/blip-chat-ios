# Projeto — BLiP Chat iOS

## O que é

SDK iOS (Swift, com API `@objc` exposta a Objective-C) que adiciona o widget de chat da BLiP a apps iOS nativos. Não é um app — é uma biblioteca distribuída para clientes/parceiros integrarem em seus próprios apps.

O SDK **não reimplementa a UI do chat em Swift**. Ele embrulha uma `WKWebView` que carrega o widget JavaScript público da BLiP (`blip-chat-widget`, publicado em `https://unpkg.com/blip-chat-widget`) dentro de um template HTML local. Ou seja, este repositório é essencialmente um **host nativo para o [blip-chat-widget](../../../blip-chat-widget)**, que por sua vez conversa com o `blip-chat` (portal/app) e a plataforma BLiP.

## Público-alvo

Desenvolvedores iOS de terceiros (clientes da BLiP) que querem embutir um chatbot BLiP em seus apps, sem construir UI de chat do zero.

## Como se distribui

- **Swift Package Manager** (recomendado, `Package.swift` na raiz) — via URL do repositório GitHub `https://github.com/takenet/blip-chat-ios`.
- **CocoaPods** (legado, mantido por compatibilidade) — pod `BlipChat`, especificado em [src/BlipChat.podspec](../../src/BlipChat.podspec).

Não há binário/framework pré-compilado ativo hoje: o SPM consome os fontes de `src/BlipChat/` diretamente. A pasta [Releases/](../../Releases/) contém `.zip` históricos usados antes da migração para SPM (era o formato de distribuição via CocoaPods `s.source :http`).

## Requisito de plataforma

iOS 15+ (definido tanto em `Package.swift` quanto no `BlipChat.podspec`, `s.ios.deployment_target`).

## API pública de entrada

Ponto de entrada único: classe `BlipClient` (em [BlipClient.swift](../../src/BlipChat/BlipClient.swift)), com dois modos de uso:

1. `BlipClient.openBlipThread(myView:appKey:options:)` — abre o chat em tela cheia, dando `push` no `UINavigationController` da view apresentadora. Requer que `myView` esteja dentro de um `UINavigationController`, senão lança `BlipErrors.emptyNoNavController`.
2. `BlipClient.getBlipThreadViewController(appKey:options:)` — retorna um `UIViewController` para ser embutido como _child view controller_ (painel lateral, por exemplo), sem exigir navigation controller.

Configuração é feita via `BlipOptions` (auth type Guest/Dev, `Account`, `ConnectionDataConfig`, URLs customizadas, título da janela).
