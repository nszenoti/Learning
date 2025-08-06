# java_jdk_notion

Absolutely — this is a great next step. The **JDK vs Java** topic trips many people up, especially when dealing with different distributions (OpenJDK, Oracle JDK, etc.). Let's break it down clearly:

---

## ✅ JDK vs Java: What’s the difference?

| Term           | What it means                                                                                         |
| -------------- | ----------------------------------------------------------------------------------------------------- |
| **Java (JRE)** | Java **Runtime Environment** — used to **run** Java programs (just the VM + standard libs)            |
| **JDK**        | Java **Development Kit** — includes **JRE + compilers + dev tools** (like `javac`, `jarsigner`, etc.) |

> So:
> ✅ JDK = full toolkit to **build & run** Java
> ✅ JRE = minimal setup to **just run** Java

---

## 📦 JDK = Tooling + Runtime

| Included in JDK        | Description                        |
| ---------------------- | ---------------------------------- |
| `java`                 | Runs Java programs                 |
| `javac`                | Compiles Java source code          |
| `javadoc`, `jar`, etc. | Tools to build, sign, document     |
| Standard Libraries     | Collections, networking, etc.      |
| JVM                    | Java Virtual Machine (the runtime) |

---

## 🔀 Different JDK Distributions

There are **many vendors** who provide JDKs — all mostly based on the **same OpenJDK source**, but with variations.

| Vendor    | Name / Flavor              | Notes                                                                  |
| --------- | -------------------------- | ---------------------------------------------------------------------- |
| Oracle    | Oracle JDK                 | Official but used to have restrictive licenses (now partially relaxed) |
| OpenJDK   | OpenJDK                    | Reference implementation — open source                                 |
| Azul      | Zulu JDK                   | Free, commercial support available                                     |
| Amazon    | Corretto                   | Free, patched, production-ready JDK                                    |
| Eclipse   | Adoptium (Temurin)         | Popular open JDK backed by the Eclipse Foundation                      |
| Microsoft | Microsoft Build of OpenJDK | Free, used internally for VS Code and Azure                            |
| JetBrains | JetBrains Runtime          | Used internally for IntelliJ products                                  |

All of them:

* Pass the same **Java Compatibility Kit (JCK)** tests
* Are **interchangeable** for most dev purposes

> ✅ For Android development, **any well-maintained OpenJDK-compatible JDK works** — usually JDK 11 or 17.

---

## 🧠 Common Misconception

**Q:** “I have Java installed. Isn’t that enough?”
**A:** Maybe not — if it's only a **JRE**, Gradle or compilers might fail.

💡 To build Java or Android projects, you need the **JDK**, not just the JRE.

---

## 🧪 How to check which JDK you're using?

```bash
java -version
javac -version
```

You might see:

```text
openjdk version "17.0.9" 2024-01-16
OpenJDK Runtime Environment Temurin-17.0.9+9
OpenJDK 64-Bit Server VM Temurin-17.0.9+9
```

Here:

* `Temurin` → means it’s from **Eclipse Adoptium**
* `OpenJDK` → means it's open-source compliant

---

## ✅ TL;DR

| Concept             | Summary                                                                   |
| ------------------- | ------------------------------------------------------------------------- |
| **JDK**             | Needed to **build and run** Java apps — includes JRE                      |
| **JRE**             | Needed only to **run** Java apps                                          |
| **Java**            | Often used as a shorthand for the runtime or language itself              |
| **Distributions**   | OpenJDK, Oracle, Temurin, Zulu, Corretto — all valid choices              |
| **For Android dev** | Use a compatible **JDK version (not just Java)** — typically JDK 11 or 17 |

---

Let me know if you’d like a recommended JDK to install for Android dev today — or how to set it globally or per-project.

