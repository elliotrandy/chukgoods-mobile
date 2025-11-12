# chukgoods_mobile

A new Flutter project.

## Getting Started

This project is a starting point for a Flutter application.

A few resources to get you started if this is your first Flutter project:

- [Lab: Write your first Flutter app](https://docs.flutter.dev/get-started/codelab)
- [Cookbook: Useful Flutter samples](https://docs.flutter.dev/cookbook)

For help getting started with Flutter development, view the
[online documentation](https://docs.flutter.dev/), which offers tutorials,
samples, guidance on mobile development, and a full API reference.

## Tugas 7

### 1. Jelaskan apa itu widget tree pada Flutter dan bagaimana hubungan parent-child (induk-anak) bekerja antar widget.

Widget tree adalah struktur hierarki dari widget-widget yang membentuk UI aplikasi Flutter. Setiap widget dapat memiliki satu atau lebih child widget, dan hubungan parent-child bekerja dengan cara parent widget mengatur layout dan perilaku child-nya. Parent widget bertanggung jawab atas positioning, sizing, dan rendering child widget. Misalnya, Scaffold adalah parent yang memiliki AppBar dan body sebagai child.

### 2. Sebutkan semua widget yang kamu gunakan dalam proyek ini dan jelaskan fungsinya.

- MaterialApp: Widget root yang menyediakan tema dan navigasi untuk aplikasi Material Design.
- Scaffold: Struktur dasar halaman dengan AppBar, body, dan floating action button.
- AppBar: Bar atas halaman yang menampilkan judul.
- Padding: Menambahkan padding di sekitar child widget.
- Column: Mengatur child widget secara vertikal.
- Row: Mengatur child widget secara horizontal.
- Center: Memposisikan child di tengah parent.
- Text: Menampilkan teks.
- Card: Container dengan elevation untuk menampilkan informasi.
- Container: Widget yang dapat dikustomisasi untuk layout.
- GridView.count: Menampilkan child dalam grid dengan jumlah kolom tertentu.
- Material: Widget yang memberikan efek material seperti warna dan border radius.
- InkWell: Membuat area yang dapat diklik dengan efek ripple.
- Icon: Menampilkan ikon.
- SizedBox: Memberikan jarak antar widget.
- ScaffoldMessenger: Menampilkan snackbar.

### 3. Apa fungsi dari widget MaterialApp? Jelaskan mengapa widget ini sering digunakan sebagai widget root.

MaterialApp adalah widget yang menyediakan konfigurasi untuk aplikasi Material Design, termasuk tema, routing, dan lokalization. Ia sering digunakan sebagai root karena menyediakan semua konfigurasi dasar yang diperlukan untuk aplikasi Flutter, seperti tema warna, font, dan navigasi antar halaman.

### 4. Jelaskan perbedaan antara StatelessWidget dan StatefulWidget. Kapan kamu memilih salah satunya?

StatelessWidget adalah widget yang tidak memiliki state internal dan tidak berubah selama lifecycle-nya. StatefulWidget memiliki state yang dapat berubah, dan menggunakan State object untuk mengelola perubahan. Pilih StatelessWidget untuk widget statis yang tidak perlu update, dan StatefulWidget untuk widget yang perlu merespons interaksi pengguna atau data yang berubah.

### 5. Apa itu BuildContext dan mengapa penting di Flutter? Bagaimana penggunaannya di metode build?

BuildContext adalah objek yang menyediakan informasi tentang lokasi widget dalam widget tree. Ia penting karena digunakan untuk mengakses tema, media query, dan ancestor widget. Di metode build, BuildContext digunakan untuk mendapatkan informasi kontekstual seperti ukuran layar atau tema aplikasi.

### 6. Jelaskan konsep "hot reload" di Flutter dan bagaimana bedanya dengan "hot restart".

Hot reload memperbarui kode aplikasi tanpa kehilangan state aplikasi, sehingga perubahan UI langsung terlihat. Hot restart me-restart aplikasi sepenuhnya, menghilangkan state dan memuat ulang aplikasi dari awal. Hot reload lebih cepat untuk perubahan UI, sedangkan hot restart diperlukan untuk perubahan struktural seperti main.dart.

## Tugas 8

### 1. Jelaskan perbedaan antara Navigator.push() dan Navigator.pushReplacement() pada Flutter. Dalam kasus apa sebaiknya masing-masing digunakan pada aplikasi Football Shop kamu?

Navigator.push() menambahkan route baru ke stack navigation, sehingga pengguna dapat menggunakan tombol back untuk kembali ke halaman sebelumnya. Navigator.pushReplacement() menggantikan route teratas (topmost route) dengan route baru, sehingga pengguna tidak dapat kembali ke halaman sebelumnya dengan tombol back.

Di aplikasi CHUKGOODS saya:
- Navigator.push() digunakan untuk navigasi ke halaman form tambah produk, sehingga pengguna dapat kembali ke halaman utama setelah selesai mengisi form
- Navigator.pushReplacement() digunakan untuk navigasi drawer dari halaman utama ke halaman form, karena tidak ingin pengguna kembali ke halaman utama melalui tombol back ketika sedang mengisi form

### 2. Bagaimana kamu memanfaatkan hierarchy widget seperti Scaffold, AppBar, dan Drawer untuk membangun struktur halaman yang konsisten di seluruh aplikasi?

Saya memanfaatkan widget hierarchy dengan:
- Scaffold sebagai container utama untuk setiap halaman yang menyediakan struktur standar (AppBar, body, drawer)
- AppBar dengan judul yang konsisten dan styling yang seragam untuk memberikan identitas visual aplikasi
- Drawer yang berisi menu navigasi dengan opsi "Halaman Utama" dan "Tambah Produk" untuk memberikan akses navigasi yang mudah
- Konsistensi dalam styling, warna tema, dan spacing untuk menciptakan pengalaman pengguna yang cohesif

### 3. Dalam konteks desain antarmuka, apa kelebihan menggunakan layout widget seperti Padding, SingleChildScrollView, dan ListView saat menampilkan elemen-elemen form? Berikan contoh penggunaannya dari aplikasi kamu.

- Padding memberikan ruang yang konsisten antar elemen form, meningkatkan readability dan usability.
- SingleChildScrollView memungkinkan form yang panjang dapat di-scroll secara vertikal tanpa membutuhkan ukuran layar tertentu, sangat berguna untuk form dengan banyak field.
- ListView efisien untuk menampilkan daftar item yang dapat di-scroll dengan built-in scrolling behavior.

Contoh implementasi dalam aplikasi saya:
```dart
// Padding untuk spacing antar field
Padding(
  padding: const EdgeInsets.all(16.0),
  child: Column(children: [...])
)

// SingleChildScrollView untuk form yang panjang
SingleChildScrollView(
  padding: const EdgeInsets.all(16.0),
  child: Column(
    children: [
      TextFormField(...), // Name field
      const SizedBox(height: 16),
      TextFormField(...), // Price field
      // ... more fields
    ],
  ),
)

// Dropdown form field dengan proper scrolling
DropdownButtonFormField<String>(
  items: categories.map(...).toList(),
)
```

### 4. Bagaimana kamu menyesuaikan warna tema agar aplikasi Football Shop memiliki identitas visual yang konsisten dengan brand toko?

Saya menyesuaikan tema aplikasi dengan mendefinisikan color scheme yang konsisten di MaterialApp:

```dart
MaterialApp(
  title: 'CHUKGOODS',
  theme: ThemeData(
    colorScheme: ColorScheme.fromSwatch(primarySwatch: Colors.blue)
        .copyWith(secondary: Colors.blueAccent[400]),
  ),
)
```

Kemudian menggunakan warna yang sama untuk:
- AppBar dengan `backgroundColor: Theme.of(context).colorScheme.primary`
- Button dengan `MaterialStateProperty.all(Colors.blue)`
- Checkbox dan interactive elements dengan `activeColor: Theme.of(context).colorScheme.primary`