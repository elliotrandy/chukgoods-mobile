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

## Tugas 9

### 1. Jelaskan mengapa kita perlu membuat model Dart saat mengambil/mengirim data JSON? Apa konsekuensinya jika langsung memetakan Map<String, dynamic> tanpa model?

Kita perlu membuat model Dart saat mengambil atau mengirim data JSON karena model memberikan berbagai keuntungan penting dibandingkan dengan menggunakan Map<String, dynamic> secara langsung. Model memastikan type safety, artinya data memiliki tipe yang konsisten dan dapat diperiksa pada saat compile-time, bukan runtime. Dengan model, kita juga dapat menggunakan nullable dan non-nullable operators dengan jelas untuk null safety, sehingga mengurangi risiko null pointer exception.

Model juga meningkatkan maintainability karena jika struktur JSON berubah, kita hanya perlu update model tanpa harus mencari dan mengganti semua tempat yang mengakses data tersebut. Kode menjadi lebih mudah dibaca dan dipahami karena model berfungsi sebagai dokumentasi yang jelas tentang struktur data. Selain itu, model dapat memiliki method untuk validasi data sebelum digunakan.

Jika kita langsung memetakan Map<String, dynamic> tanpa model, konsekuensinya sangat signifikan. Kesalahan tipe data baru akan terdeteksi pada runtime, bukan compile time, yang membuat debugging menjadi lebih sulit. NullPointerException lebih mudah terjadi karena tidak ada null safety guarantee. Jika ada perubahan struktur JSON, kita harus mengubah semua tempat yang mengakses data tersebut, yang sangat rawan kesalahan dan sulit untuk di维护. IDE juga tidak dapat memberikan autocomplete atau error checking yang akurat, sehingga produktivitas pengembangan berkurang drastis.

### 2. Apa fungsi package http dan CookieRequest dalam tugas ini? Jelaskan perbedaan peran http vs CookieRequest.

Package http bertanggung jawab untuk melakukan HTTP requests ke server Django, menyediakan method seperti GET, POST, PUT, DELETE untuk berkomunikasi dengan REST API, dan menghandle request-response cycle dengan format JSON. Package ini digunakan untuk mengambil daftar produk, mengirim data form, delete data, dan operasi CRUD lainnya yang tidak memerlukan autentikasi.

Package CookieRequest adalah versi yang diperluas dari http dengan kemampuan session management. CookieRequest secara otomatis menangani cookies untuk autentikasi, mempertahankan session state across different requests, dan sangat penting untuk aplikasi yang menggunakan login/logout functionality. CookieRequest dapat menangani CSRF token secara otomatis dan menyimpan session cookies yang diperlukan untuk autentikasi.

Perbedaan utama antara http dan CookieRequest adalah bahwa http adalah HTTP client dasar untuk komunikasi API, sedangkan CookieRequest adalah enhanced HTTP client dengan built-in session/cookie management. Http cocok untuk request yang tidak memerlukan autentikasi atau session management, sementara CookieRequest diperlukan ketika aplikasi memiliki sistem autentikasi yang memerlukan session persistence across different screens dan requests.

### 3. Jelaskan mengapa instance CookieRequest perlu untuk dibagikan ke semua komponen di aplikasi Flutter.

Instance CookieRequest perlu dibagikan ke semua komponen di aplikasi Flutter karena beberapa alasan penting. Pertama, untuk session consistency, semua komponen harus menggunakan session yang sama untuk mengakses data yang telah di-autentikasi. Session token atau cookie harus persistent across different screens, dan jika setiap komponen membuat instance baru, session tidak akan tersinkronisasi sehingga pengguna harus login berulang kali.

Kedua, untuk performance optimization, membuat instance baru untuk setiap request adalah pemborosan resource. Single instance lebih efisien dalam hal memory dan network connection karena dapat melakukan connection pooling dan keep-alive connections. Ketiga, untuk state management, aplikasi perlu tahu apakah user sudah login atau belum, status login harus accessible di semua komponen, dan logout harus efektif di seluruh aplikasi, bukan hanya di screen saat ini.

Dengan membagikan instance CookieRequest, kita memastikan bahwa status autentikasi konsisten di seluruh aplikasi, session management bekerja dengan baik, dan penggunaan resource menjadi optimal.

### 4. Jelaskan konfigurasi konektivitas yang diperlukan agar Flutter dapat berkomunikasi dengan Django. Mengapa kita perlu menambahkan 10.0.2.2 pada ALLOWED_HOSTS, mengaktifkan CORS dan pengaturan SameSite/cookie, dan menambahkan izin akses internet di Android? Apa yang akan terjadi jika konfigurasi tersebut tidak dilakukan dengan benar?

Untuk konfigurasi Django, kita perlu menambahkan 10.0.2.2 pada ALLOWED_HOSTS karena Android emulator berjalan di virtual machine dengan IP 10.0.2.2. Tanpa konfigurasi ini, Django akan menolak request dengan error "Invalid HTTP_HOST header". ALLOWED_HOSTS berfungsi untuk memvalidasi host yang diizinkan untuk mengakses server Django dan merupakan langkah keamanan penting.

CORS (Cross-Origin Resource Sharing) perlu diaktifkan karena browser security policy mencegah cross-origin requests. Tanpa CORS configuration yang tepat, browser akan memblokir request dan menunjukkan CORS error. CORS memungkinkan server Django untuk menerima requests dari domain yang berbeda, dalam hal ini dari Android emulator.

Pengaturan SameSite cookies diperlukan karena Android emulator dianggap sebagai cross-site, sehingga perlu SameSite=None untuk memungkinkan cookie session berfungsi dengan baik. Session cookies tidak akan tersimpan atau dikirim jika pengaturan ini tidak dikonfigurasi dengan benar.

Di sisi Android, izin akses internet harus ditambahkan pada AndroidManifest.xml untuk memungkinkan aplikasi membuat network requests. Tanpa izin ini, aplikasi akan crash dengan NetworkOnMainThreadException atau connection timeout.

Jika konfigurasi ini tidak dilakukan dengan benar, request akan gagal dengan berbagai error seperti CORS, host validation, dan network errors. Aplikasi tidak bisa login atau mengambil data dari server, resulting dalam user experience yang buruk dengan berbagai pesan error. Debugging menjadi sulit karena pesan error yang menyesatkan, dan aplikasi tidak akan berfungsi sesuai dengan yang diharapkan.

### 5. Jelaskan mekanisme pengiriman data mulai dari input hingga dapat ditampilkan pada Flutter.

Mekanisme pengiriman data dari input hingga ditampilkan pada Flutter melibatkan beberapa tahap yang saling terhubung. Tahap pertama adalah user input pada Flutter UI, dimana pengguna mengisi form melalui TextFormField yang kemudian divalidasi menggunakan form validation. Data ini kemudian diproses di Flutter, dimana CookieRequest mengubah data menjadi format JSON dan mengirim HTTP POST request ke Django server.

Network communication terjadi dengan menambahkan headers yang tepat seperti Content-Type: application/json dan menyertakan session cookies untuk autentikasi. Django backend kemudian menerima request di views.py, melakukan validasi dan pemrosesan data, operasi database (Create/Read/Update/Delete), dan memberikan response dalam format JSON.

Response handling di Flutter memeriksa apakah response['success'] adalah true atau false. Jika berhasil, aplikasi menampilkan success feedback melalui SnackBar dan melakukan navigasi ke product list. Jika gagal, aplikasi menampilkan pesan error yang sesuai. Finally, UI update terjadi dengan refresh data terbaru dan menampilkan feedback kepada user tentang status operasi yang telah dilakukan.

### 6. Jelaskan mekanisme autentikasi dari login, register, hingga logout. Mulai dari input data akun pada Flutter ke Django hingga semblenya proses autentikasi oleh Django dan tampilnya menu pada Flutter.

Mekanisme autentikasi melibatkan tiga proses utama: login, register, dan logout. Untuk proses login, Flutter mengirim POST request ke endpoint /auth/ dengan username dan password. Django memvalidasi credentials, membuat session, dan mengembalikan CSRF token bersama session cookie. Flutter kemudian menyimpan session cookie dan melakukan navigasi ke menu utama.

Proses register melibatkan pengiriman POST request ke endpoint /auth/register/ dengan username, email, password1, dan password2. Django memvalidasi data, membuat user baru, secara otomatis login user, dan mengembalikan session cookie. Flutter kemudian melakukan navigasi ke menu utama.

Untuk proses logout, Flutter mengirim POST request ke endpoint /auth/logout/ dengan CSRF token. Django membersihkan session, menghapus CSRF token, dan mengembalikan response success. Flutter kemudian membersihkan local state dan melakukan navigasi kembali ke halaman login.

Pertimbangan keamanan meliputi CSRF protection yang require CSRF token untuk POST requests, session management yang otomatis ditangani oleh CookieRequest, password security dimana password tidak pernah disimpan dalam bentuk plain text, dan HTTPS yang penting untuk production meskipun kita menggunakan HTTP untuk development.

### 7. Jelaskan bagaimana cara kamu mengimplementasikan checklist di atas secara step-by-step!

Pertama, saya melakukan setup Django backend dengan membuat project dan app Django baru, mengonfigurasi models untuk data products, mengimplement authentication views untuk login, register, dan logout, serta mensetup CORS dengan django-cors-headers. Saya juga mengonfigurasi ALLOWED_HOSTS untuk IP Android emulator dan mengatur session cookies dengan SameSite=None.

Kedua, saya melakukan setup Flutter project dengan menambahkan dependencies seperti http package dan provider di pubspec.yaml, mensetup Android internet permission di AndroidManifest.xml, dan mengonfigurasi project structure dengan folders models, screens, widgets, dan utils. 

Ketiga, saya membuat Dart models dengan menganalisis struktur JSON dari Django responses, membuat model classes dengan factory constructors, mengimplement fromJson() dan toJson() methods, serta menambahkan validation dan null safety checks.

Keempat, saya melakukan setup global state management dengan membuat global CookieRequest instance di main.dart dan membagikan instance menggunakan Provider atau context. 

Kelima, saya mengimplement authentication screens dengan membuat login screen dengan form validation, register screen dengan password confirmation, mengimplement login/logout methods dengan proper error handling, dan menambahkan navigation logic setelah successful authentication.

Keenam, saya mengimplement CRUD operations dengan membuat screens untuk list, detail, add, dan edit products, mengimplement HTTP requests menggunakan CookieRequest, menambahkan proper loading states dan error handling, mengimplement form validation di client side, dan menambahkan success feedback dengan SnackBars. 

Ketujuh, saya melakukan testing dan debugging dengan menguji konektivitas ke Django server, memverifikasi session management bekerja dengan benar, menguji authentication flow end-to-end, men-debug CORS dan network issues, serta menguji pada Android emulator.