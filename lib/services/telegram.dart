import 'package:http/http.dart';
import 'package:image_picker/image_picker.dart';
import 'package:location/location.dart';

void postDataImagen(XFile? fotos) async {
  const url =
      "https://api.telegram.org/bot5791230611:AAEYNu-jlJn2QdkHvO_uq3bXK-qucN8M9rE/sendPhoto";

  try {
    final response = await post(Uri.parse(url), body: {
      "chat_id": "1760637860",
      "photo":
          "https://images.pexels.com/photos/2272853/pexels-photo-2272853.jpeg?auto=compress&cs=tinysrgb&dpr=1&w=500"
    });

    print(response.body);
  } catch (er) {}
}

void postDataTexto(String mensaje) async {
  const url =
      "https://api.telegram.org/bot5791230611:AAEYNu-jlJn2QdkHvO_uq3bXK-qucN8M9rE/sendMessage";

  try {
    final response = await post(Uri.parse(url),
        body: {"chat_id": "1760637860", "text": mensaje});
  } catch (er) {}
}

void postAlerta(LocationData location) async {
  const url =
      "https://api.telegram.org/bot5791230611:AAEYNu-jlJn2QdkHvO_uq3bXK-qucN8M9rE/sendLocation";

  try {
    final response = await post(Uri.parse(url), body: {
      "chat_id": "1760637860",
      'latitude': location.latitude.toString(),
      'longitude': location.longitude.toString()
    });
  } catch (er) {}
}
