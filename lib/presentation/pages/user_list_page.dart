import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/user_provider.dart';
import '../widget/user_card.dart';
import 'user_detail_page.dart';

class UserListPage extends StatefulWidget {
  const UserListPage({super.key});

  @override
  State<UserListPage> createState() => _UserListPageState();
}

class _UserListPageState extends State<UserListPage> {
  String searchQuery = '';
  String selectedCity = 'Todas';

  @override
  Widget build(BuildContext context) {
    final userProvider = Provider.of<UserProvider>(context);

    // Obtener lista de ciudades únicas
    final cities = [
      'Todas',
      ...{
        for (var user in userProvider.users)
          user.address?.city ?? 'Desconocida'
      }.toList()
    ];

    // Filtrar por búsqueda y ciudad
    final filteredUsers = userProvider.users.where((user) {
      final matchesName = user.name.toLowerCase().contains(searchQuery.toLowerCase());
      final matchesCity = selectedCity == 'Todas' ||
          (user.address?.city ?? '').toLowerCase() == selectedCity.toLowerCase();
      return matchesName && matchesCity;
    }).toList();

    return Scaffold(
      appBar: AppBar(
        title: const Text('Usuarios'),
        bottom: PreferredSize(
          preferredSize: const Size.fromHeight(100),
          child: Padding(
            padding: const EdgeInsets.all(12),
            child: Column(
              children: [
                // Búsqueda
                TextField(
                  decoration: InputDecoration(
                    hintText: 'Buscar por nombre...',
                    prefixIcon: const Icon(Icons.search),
                    filled: true,
                    fillColor: Colors.white,
                    contentPadding: const EdgeInsets.all(12),
                    border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
                  ),
                  onChanged: (value) {
                    setState(() {
                      searchQuery = value;
                    });
                  },
                ),
                const SizedBox(height: 10),
                // Filtro por ciudad
                DropdownButtonFormField<String>(
                  value: selectedCity,
                  items: cities.map((city) {
                    return DropdownMenuItem(
                      value: city,
                      child: Text(city),
                    );
                  }).toList(),
                  decoration: InputDecoration(
                    labelText: 'Filtrar por ciudad',
                    border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
                    contentPadding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                  ),
                  onChanged: (value) {
                    if (value != null) {
                      setState(() {
                        selectedCity = value;
                      });
                    }
                  },
                ),
              ],
            ),
          ),
        ),
      ),
      body: userProvider.isLoading
          ? const Center(child: CircularProgressIndicator())
          : ListView.builder(
        itemCount: filteredUsers.length,
        itemBuilder: (context, index) {
          final user = filteredUsers[index];
          return UserCard(
            user: user,
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (_) => UserDetailPage(user: user),
                ),
              );
            },
          );
        },
      ),
    );
  }
}
