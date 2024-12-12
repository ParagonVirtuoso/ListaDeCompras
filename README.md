# Lista de Compras iOS

Um aplicativo iOS para gerenciar suas listas de compras de forma eficiente e intuitiva, desenvolvido com SwiftUI e SwiftData.

## 🚀 Funcionalidades

- Criar múltiplas listas de compras
- Adicionar, editar e remover itens
- Marcar itens como comprados
- Categorizar itens
- Persistência local de dados com SwiftData
- Suporte a temas claro/escuro
- Interface responsiva

## 🛠 Tecnologias Utilizadas

- Swift
- SwiftUI
- SwiftData
- MVVM Architecture
- Combine Framework
- XCTest para testes unitários e UI

## 🏗 Arquitetura

O projeto segue a arquitetura MVVM (Model-View-ViewModel) com as seguintes camadas:

- **Models**: Entidades de dados e lógica de negócios
- **Views**: Interface do usuário em SwiftUI
- **ViewModels**: Lógica de apresentação e estado
- **Services**: Camada de acesso a dados e serviços
- **Utils**: Componentes utilitários e extensões

## 🔄 Fluxo de Dados

1. Views observam ViewModels
2. ViewModels processam dados dos Models
3. Models são persistidos via SwiftData
4. Services gerenciam operações de dados

## 🛠 Como Configurar

1. Clone o repositório
2. Abra o projeto no Xcode
3. Rode o projeto no simulador ou dispositivo físico

## 🧪 Testes

O projeto inclui:
- Testes unitários para ViewModels
- Testes de integração para Services
- Testes de UI para fluxos principais

Execute os testes com ⌘ + U no Xcode.

## 🚀 Funcionalidades Futuras

- [ ] Sincronização com iCloud ou supabase
- [ ] Compartilhamento de listas
- [ ] Histórico de compras
- [ ] Estimativa de preços
- [ ] Sugestões inteligentes de itens
- [ ] Temas personalizados
- [ ] Widgets para iOS