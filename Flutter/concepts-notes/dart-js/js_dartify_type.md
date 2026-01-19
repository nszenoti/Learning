# js_dartify_type

| JS Return Type     | `dartify()` Output | Dart Type              |
| ------------------ | ------------------ | ---------------------- |
| `string`           | `"hello"`          | `String`               |
| `number`           | `42`               | `int` or `double`      |
| `boolean`          | `true`             | `bool`                 |
| `null`/`undefined` | `null`             | `Null`                 |
| `Array`            | `[1, 2, 3]`        | `List<dynamic>`        |
| `Object`           | `{"key": "value"}` | `Map<String, dynamic>` |
| `Function`         | **Error**          | Throws                 |
