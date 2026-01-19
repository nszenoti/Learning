# file_export

Exactly ✅ — that’s the convenience of **`image_gallery_saver`**.

Here’s how it behaves:

---

### 📱 On **Android**

* **Android 10+ (Scoped Storage)** → saves via **MediaStore** into the **Pictures** collection.

  * Image is visible in **Gallery / Photos app**.
  * ✅ No permission needed.
* **Android 9 and below** → saves directly into the **DCIM/Pictures** folder.

  * ⚠️ Needs `WRITE_EXTERNAL_STORAGE` runtime permission.

---

### 🍏 On **iOS**

* Saves directly into the **Photos app (Camera Roll)**.
* Uses iOS Photo APIs.
* ✅ Needs **Photos permission** (`NSPhotoLibraryAddUsageDescription` in `Info.plist`, plus runtime request).

---

### ⚖️ In short:

* `image_gallery_saver` = **“Save this image to the user’s gallery/photos app”**,
* It handles platform differences for you, so you don’t have to worry about which folder to pick.
* You only need to handle **permissions for older Android (≤ 9)** and **Photos permission on iOS**.

---

👉 So yes — it works across platforms and automatically saves to the **appropriate public media location**.

Would you like me to show you a **minimal Flutter snippet** using `image_gallery_saver` that:

* Requests the correct permission only if required (Android ≤ 9 or iOS),
* Saves an image to the right folder (Gallery/Photos)?
