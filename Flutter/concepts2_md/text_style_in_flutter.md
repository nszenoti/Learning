Yes! The `Text` widget does **inherit styles** from the nearest `DefaultTextStyle`, which is set globally by `MaterialApp.textTheme`.  

### **How `Text` Inherits Styles Automatically**
If you **don’t provide a `TextStyle`** to `Text`, it automatically uses `DefaultTextStyle.of(context).style`, which is linked to `Theme.of(context).textTheme.bodyMedium` (or another appropriate text style).

#### **Example: Automatic Inheritance**
```dart
Text("Hello World") // Uses Theme.of(context).textTheme.bodyMedium automatically
```

But **if you specify `TextStyle()` manually**, it will **override** everything and lose the inherited styles.

---

### **Why `TextStyle()` Alone Doesn't Inherit?**
When you do:
```dart
Text(
  "Hello",
  style: TextStyle(), // This resets everything (color, font, weight)
)
```
- You are **replacing** the default style.
- It **won’t merge** with the global theme.
- So, the text may **appear different** from the rest of your app.

---

### **Correct Way to Modify Only the Font**
To **keep the global style** but only change the font, merge it:
```dart
Text(
  "Hello",
  style: Theme.of(context).textTheme.bodyMedium?.merge(GoogleFonts.roboto()),
)
```
OR  
Use `copyWith()`:
```dart
Text(
  "Hello",
  style: Theme.of(context).textTheme.bodyMedium?.copyWith(fontFamily: GoogleFonts.roboto().fontFamily),
)
```

---

### **Key Takeaways**
✅ **Text Widget Inherits Automatically** if no style is given.  
✅ **Using `TextStyle()` alone resets styles** (losing theme settings).  
✅ **Merge or copyWith()** to modify only specific attributes (like font family) without affecting other properties. 🚀