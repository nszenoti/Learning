rnn_why_evaluation

Great question!

In Recurrent Neural Networks (RNNs), the internal state (or hidden state) at each time step is **not directly updated based on the original input alone** — instead, it incorporates the **output of the network from the previous time step** (often referred to as the "evaluation" or the transformed hidden state).

Let’s break it down and clarify your question.

---

### 🧠 Why RNN uses the evaluation (hidden state) instead of original value for internal state:

RNNs are designed to **capture temporal dependencies** — that is, to remember information over sequences.

Each time step \( t \) processes:

- **Input**: \( x_t \) (original value at time step \( t \))
- **Previous hidden state**: \( h_{t-1} \) (which is already a transformed, learned representation — i.e., an "evaluation")

And it updates:

- **Current hidden state**:  
  \[
  h_t = f(W_x x_t + W_h h_{t-1} + b)
  \]

So why not use the original value of the hidden state instead?

---

### 📌 Reasons for using evaluated state instead of raw values:

1. **Learned representation**:  
   The hidden state \( h_t \) is a learned, compressed, and meaningful representation of everything the RNN has "seen" up to time \( t \). It’s not just the original values — it's a summary of context.

2. **Temporal memory**:  
   RNNs are meant to remember the past. The hidden state acts like the memory — and memory is not a raw snapshot but an interpretation (like how you remember "the story" and not every word).

3. **Backpropagation Through Time (BPTT)**:  
   Training uses the computed hidden states to propagate error back through the sequence. If we used just the raw values, the network would lose its ability to adjust based on temporal patterns.

4. **Efficiency**:  
   Updating based on raw values (e.g., stacking the entire past) would explode in memory usage and make training unstable. Instead, we keep the internal state fixed-size and meaningful.

---

### 🧬 Analogy:

Think of it like a person writing a story:

- The current sentence \( x_t \) depends on both the prompt \( x_t \) and their **memory** of the previous sentences \( h_{t-1} \), not just a stack of raw words.

---

### TL;DR:

RNNs use the evaluated hidden state — not raw values — because:
- It encapsulates learned temporal context,
- Enables memory of past sequence data,
- Keeps the state manageable and trainable,
- And allows meaningful backpropagation.

Let me know if you’re thinking in terms of LSTM/GRU, or a specific implementation — I can go deeper!