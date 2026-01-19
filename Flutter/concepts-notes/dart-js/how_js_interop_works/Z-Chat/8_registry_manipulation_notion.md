# 8_registry_manipulation_notion

So this registry is handled via Dart

but manipulation ie create/delete in registry is led by Proxy objects only ?

Ans precisely

---


Precisely. Your understanding is correct, with a key distinction between the creation and deletion processes.

The Dart runtime manages the registry, but the **lifecycle of the `JSFunction` proxy object is the direct trigger for deletion.**

Here is the precise breakdown:

### 1. Registry Creation (Proactive)

The creation of the registry entry is **not** led by the proxy object, because the proxy doesn't exist yet.

*   **Actor:** The **Dart Runtime**.
*   **Trigger:** The execution of the `.toJS` method on your original Dart function.

When you call `callback.toJS`, the Dart runtime performs a sequence of actions:
1.  Creates the actual JavaScript function in the JS heap.
2.  Creates the `JSFunction` proxy object in the Dart heap.
3.  **Proactively creates a new entry in its internal registry**, mapping a new ID to your original Dart function.

The registry creation is an integral part of the `.toJS` execution itself.

### 2. Registry Deletion (Reactive)

The deletion of the registry entry is **directly and exclusively led by the lifecycle of the `JSFunction` proxy 

---

# Registry Process


Yes, you are absolutely correct. That is a crucial logical point.

The **registry ID must be created first**. It is the foundational piece of information that allows the other components to be built and linked.

Here is the precise logical sequence of what happens when you call `callback.toJS`:

1.  **Generate ID:** The Dart runtime generates a unique ID (e.g., `123`).
2.  **Create Registry Entry:** It immediately adds an entry to its internal registry, mapping this new ID to your original Dart function object.
    `_registry[123] = yourOriginalDartFunction;`
3.  **Create the JavaScript Function:** Now that the ID exists and is linked to the Dart function, the Dart runtime instructs the browser's JS engine to create a new JavaScript function. This newly created JS function is given the ID (`123`) to store internally. This is its "handle" for calling back to Dart.
4.  **Create the Dart Proxy (`JSFunction`):** Finally, the Dart runtime creates the `JSFunction` proxy object in the Dart heap. This object is then given references to both the original Dart function (for GC purposes) and the newly created JavaScript function (so Dart can manage it).

So, the flow is:

**Dart Function -> Generate ID -> Register ID -> Create JS Function (with ID) -> Create Dart Proxy**

You are right. You cannot create the JavaScript function without first having the ID that it needs to operate.