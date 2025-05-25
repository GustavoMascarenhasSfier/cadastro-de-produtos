# 📦 Cadastro de Produtos - Flutter App

Aplicativo desenvolvido em **Flutter** para cadastro, edição, visualização e exclusão de produtos. Ideal para quem deseja praticar conceitos de **CRUD** (Create, Read, Update, Delete) e gerenciamento de estados com `StatefulWidget`.

---

## 🎯 Funcionalidades

✅ Cadastro de novos produtos  
✅ Edição de produtos existentes  
✅ Exclusão de produtos  
✅ Visualização detalhada de cada produto  
✅ Indicação de status: ativo/inativo, promoção e desconto  
✅ Inclusão de imagem via URL  
✅ Interface intuitiva e moderna

---

## 🖼️ Tela de Detalhes do Produto

- Nome, preços de compra e venda
- Quantidade em estoque
- Categoria e descrição
- Imagem do produto
- Status: ativo/inativo
- Promoção: sim/não e percentual de desconto

---

## 🚀 Como executar o projeto

### Pré-requisitos:

- [Flutter](https://flutter.dev/docs/get-started/install) instalado na sua máquina ou (https://zapp.run/)
- Dispositivo físico ou emulador configurado

### Passos:

1. Clone o repositório:

```bash
git clone https://github.com/seu-usuario/cadastro-produtos-flutter.git
```

2. Acesse a pasta do projeto:

```bash
cd cadastro-produtos-flutter
```

3. Instale as dependências:

```bash
flutter pub get
```

4. Execute o app:

```bash
flutter run
```

---

## 🛠️ Tecnologias Utilizadas

- **Flutter** (SDK)
- **Dart** (linguagem)
- Componentes nativos de UI do Flutter
  - `MaterialApp`, `Scaffold`, `ListTile`, `Card`, `Form`, etc.

---

## 📂 Estrutura do Código

- **main.dart** → Arquivo principal que configura as rotas e a navegação.
- **Product** → Modelo de dados para armazenar informações dos produtos.
- **ProductListScreen** → Tela principal com a lista de produtos.
- **ProductDetailScreen** → Tela de detalhes completos de um produto.
- **ProductFormScreen** → Tela de cadastro e edição de produtos.

---

## 📝 Melhorias Futuras

- Implementar persistência de dados local (SQLite ou Hive)
- Suporte a upload de imagens locais
- Filtros de busca e ordenação
- Autenticação de usuários

---

## 👨‍💻 Autor

Desenvolvido por **[Gustavo Mascarenhas Sfier Arando]**  
[(https://github.com/GustavoMascarenhasSfier)]

---

## 📄 Licença

Este projeto está sob a licença **MIT**. Veja o arquivo [LICENSE](LICENSE) para mais detalhes.
