import 'package:flutter/material.dart';

void main() => runApp(MyApp());

// Modelo de Produto
class Product {
  String name;
  double purchasePrice;
  double salePrice;
  int quantity;
  String description;
  String category;
  String imageUrl;
  bool isActive;
  bool onSale;
  double discount;

  Product({
    required this.name,
    required this.purchasePrice,
    required this.salePrice,
    required this.quantity,
    required this.description,
    required this.category,
    required this.imageUrl,
    required this.isActive,
    required this.onSale,
    required this.discount,
  });
}

class MyApp extends StatefulWidget {
  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  final List<Product> _products = [];

  void _addProduct(Product product) {
    setState(() => _products.add(product));
  }

  void _updateProduct(Product product, int index) {
    setState(() => _products[index] = product);
  }

  void _removeProduct(int index) {
    setState(() => _products.removeAt(index));
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Cadastro de Produtos',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(primarySwatch: Colors.indigo),
      home: ProductListScreen(
        products: _products,
        onEdit: _updateProduct,
        onDelete: _removeProduct,
        onAdd: _addProduct,
      ),
    );
  }
}

class ProductListScreen extends StatelessWidget {
  final List<Product> products;
  final Function(Product, int) onEdit;
  final Function(int) onDelete;
  final Function(Product) onAdd;

  const ProductListScreen({
    super.key,
    required this.products,
    required this.onEdit,
    required this.onDelete,
    required this.onAdd,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Produtos')),
      body: ListView.builder(
        itemCount: products.length,
        itemBuilder: (context, index) {
          final p = products[index];
          return Card(
            elevation: 4,
            margin: const EdgeInsets.all(8),
            child: ListTile(
              leading: Image.network(
                p.imageUrl,
                width: 50,
                height: 50,
                fit: BoxFit.cover,
                errorBuilder: (_, __, ___) => const Icon(Icons.broken_image),
              ),
              title: Text(p.name),
              subtitle: Text('R\$ ${p.salePrice.toStringAsFixed(2)}'),
              trailing: Wrap(
                spacing: 12,
                children: [
                  IconButton(
                    icon: const Icon(Icons.edit, color: Colors.orange),
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (_) => ProductFormScreen(
                            onSubmit: (prod) => onEdit(prod, index),
                            existingProduct: p,
                          ),
                        ),
                      );
                    },
                  ),
                  IconButton(
                    icon: const Icon(Icons.delete, color: Colors.red),
                    onPressed: () => onDelete(index),
                  ),
                ],
              ),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (_) => ProductDetailScreen(product: p),
                  ),
                );
              },
            ),
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        child: const Icon(Icons.add),
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (_) => ProductFormScreen(onSubmit: onAdd),
            ),
          );
        },
      ),
    );
  }
}

class ProductDetailScreen extends StatelessWidget {
  final Product product;

  const ProductDetailScreen({super.key, required this.product});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Detalhes do Produto'),
        backgroundColor: Colors.indigo,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Card(
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
          color: Colors.deepPurple[50],
          elevation: 4,
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Nome: ${product.name}',
                  style: const TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: Colors.indigo,
                  ),
                ),
                const Divider(),
                Text('Preço de compra: R\$ ${product.purchasePrice.toStringAsFixed(2)}'),
                Text('Preço de venda: R\$ ${product.salePrice.toStringAsFixed(2)}'),
                Text('Quantidade: ${product.quantity}'),
                Text('Categoria: ${product.category}'),
                Text('Descrição: ${product.description}'),
                const Divider(),
                Center(
                  child: Image.network(
                    product.imageUrl,
                    height: 150,
                    errorBuilder: (_, __, ___) => const Icon(Icons.broken_image, size: 100),
                  ),
                ),
                const Divider(),
                Row(
                  children: [
                    Icon(Icons.check_circle, color: product.isActive ? Colors.green : Colors.grey),
                    const SizedBox(width: 8),
                    Text('Produto Ativo: ${product.isActive ? "Sim" : "Não"}'),
                  ],
                ),
                const SizedBox(height: 8),
                Row(
                  children: [
                    Icon(Icons.local_offer, color: product.onSale ? Colors.red : Colors.grey),
                    const SizedBox(width: 8),
                    Text('Em Promoção: ${product.onSale ? "Sim" : "Não"}'),
                  ],
                ),
                const SizedBox(height: 8),
                Row(
                  children: [
                    const Icon(Icons.percent, color: Colors.black54),
                    const SizedBox(width: 8),
                    Text('Desconto: ${product.discount.toStringAsFixed(0)}%'),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class ProductFormScreen extends StatefulWidget {
  final Function(Product) onSubmit;
  final Product? existingProduct;

  const ProductFormScreen({super.key, required this.onSubmit, this.existingProduct});

  @override
  State<ProductFormScreen> createState() => _ProductFormScreenState();
}

class _ProductFormScreenState extends State<ProductFormScreen> {
  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  final _purchasePriceController = TextEditingController();
  final _salePriceController = TextEditingController();
  final _quantityController = TextEditingController();
  final _descriptionController = TextEditingController();
  final _categoryController = TextEditingController();
  final _imageUrlController = TextEditingController();

  bool _isActive = true;
  bool _onSale = false;
  double _discount = 0.0;

  @override
  void initState() {
    super.initState();
    if (widget.existingProduct != null) {
      final p = widget.existingProduct!;
      _nameController.text = p.name;
      _purchasePriceController.text = p.purchasePrice.toString();
      _salePriceController.text = p.salePrice.toString();
      _quantityController.text = p.quantity.toString();
      _descriptionController.text = p.description;
      _categoryController.text = p.category;
      _imageUrlController.text = p.imageUrl;
      _isActive = p.isActive;
      _onSale = p.onSale;
      _discount = p.discount;
    }
  }

  void _submitForm() {
    if (_formKey.currentState!.validate()) {
      final product = Product(
        name: _nameController.text,
        purchasePrice: double.parse(_purchasePriceController.text),
        salePrice: double.parse(_salePriceController.text),
        quantity: int.parse(_quantityController.text),
        description: _descriptionController.text,
        category: _categoryController.text,
        imageUrl: _imageUrlController.text,
        isActive: _isActive,
        onSale: _onSale,
        discount: _discount,
      );
      widget.onSubmit(product);
      Navigator.pop(context);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.existingProduct == null ? 'Cadastrar Produto' : 'Editar Produto'),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Form(
          key: _formKey,
          child: Column(children: [
            TextFormField(
              controller: _nameController,
              decoration: const InputDecoration(labelText: 'Nome'),
              validator: (value) => value!.isEmpty ? 'Campo obrigatório' : null,
            ),
            TextFormField(
              controller: _purchasePriceController,
              decoration: const InputDecoration(labelText: 'Preço de compra'),
              keyboardType: TextInputType.number,
              validator: (value) => value!.isEmpty ? 'Campo obrigatório' : null,
            ),
            TextFormField(
              controller: _salePriceController,
              decoration: const InputDecoration(labelText: 'Preço de venda'),
              keyboardType: TextInputType.number,
              validator: (value) => value!.isEmpty ? 'Campo obrigatório' : null,
            ),
            TextFormField(
              controller: _quantityController,
              decoration: const InputDecoration(labelText: 'Quantidade'),
              keyboardType: TextInputType.number,
              validator: (value) => value!.isEmpty ? 'Campo obrigatório' : null,
            ),
            TextFormField(
              controller: _descriptionController,
              decoration: const InputDecoration(labelText: 'Descrição'),
              validator: (value) => value!.isEmpty ? 'Campo obrigatório' : null,
            ),
            TextFormField(
              controller: _categoryController,
              decoration: const InputDecoration(labelText: 'Categoria'),
            ),
            TextFormField(
              controller: _imageUrlController,
              decoration: const InputDecoration(labelText: 'URL da imagem'),
            ),
            const SizedBox(height: 12),
            SwitchListTile(
              title: const Text('Produto Ativo'),
              value: _isActive,
              onChanged: (val) => setState(() => _isActive = val),
            ),
            CheckboxListTile(
              title: const Text('Em Promoção'),
              value: _onSale,
              onChanged: (val) => setState(() => _onSale = val!),
            ),
            const SizedBox(height: 8),
            if (_onSale)
              Column(
                children: [
                  const Text('Desconto (%)'),
                  Slider(
                    value: _discount,
                    min: 0,
                    max: 100,
                    divisions: 20,
                    label: '${_discount.round()}%',
                    onChanged: (val) => setState(() => _discount = val),
                  ),
                ],
              ),
            const SizedBox(height: 16),
            ElevatedButton.icon(
              onPressed: _submitForm,
              icon: const Icon(Icons.save),
              label: const Text('Salvar'),
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.indigo,
                padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
              ),
            )
          ]),
        ),
      ),
    );
  }
}
