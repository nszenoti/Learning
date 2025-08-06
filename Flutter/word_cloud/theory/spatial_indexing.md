spatial_indexing

ou've touched on an important point. The spatial index will typically contain *more* entries than the original occupied list because:

1. Large rectangles can span multiple grid cells
2. Each rectangle is added to *every* cell it overlaps with
3. This means a single rectangle from the occupied list might appear in multiple cells of the spatial index

For example, if a large word spans 4 grid cells, it will be referenced 4 times in the spatial index.

This is why the naive implementation that just collects all rectangles from all cells will have duplicates (hence the use of a Set in the code to remove duplicates).

However, the tradeoff is worth it when properly implemented:
- Yes, the spatial index uses more memory
- But it dramatically reduces the number of comparisons needed for collision detection
- Instead of checking against all N rectangles, you check against only those in relevant cells (often a small fraction of N)

The efficiency comes from the query phase, not the storage phase. It's similar to how a database index makes queries faster even though it requires additional storage.


---
Intutive

Let me explain with a concrete example:

Imagine you have 1,000 words placed on your canvas, spread out across the entire area. Now you want to place a new word.

**Without spatial indexing:**
- You must check your new word against ALL 1,000 existing words
- That's 1,000 collision checks for EVERY position you try
- If you try 100 positions, that's 100,000 collision checks

**With spatial indexing:**
1. Divide the canvas into a 10×10 grid (100 cells)
2. On average, each cell might contain 10-20 words (some overlap multiple cells)
3. When checking a position, you only need to check against words in that cell and adjacent cells
4. That might be ~50 words instead of 1,000
5. So 100 positions × 50 checks = 5,000 collision checks (95% reduction!)

It's like finding a book in a library:
- Without indexing: Check every book in the library
- With indexing: Go to the right section, then check only books in that section

The key insight: Most potential collisions are physically impossible because the rectangles are far apart. Spatial indexing lets you quickly eliminate these impossible collisions without checking them.

---
IMPL 

IN the implementation, the spatial index is represented as a flattened 2D grid stored in a 1D list. Here's how it works:

Each entry in the spatial index represents one cell in the grid, and contains a list of rectangles that overlap with that cell.

To map between 2D grid coordinates and the 1D list:
- A cell at position (row, col) in the 2D grid
- Maps to index (row * gridWidth + col) in the 1D list

For example, in a 10×10 grid:
- Cell (0,0) is at index 0
- Cell (0,1) is at index 1
- Cell (1,0) is at index 10
- Cell (2,3) is at index 23

When checking collisions for a rectangle:
1. Calculate which grid cells the rectangle overlaps with
   ```
   startCol = ((rect.left - minX) / gridSize).floor()
   endCol = ((rect.right - minX) / gridSize).floor()
   startRow = ((rect.top - minY) / gridSize).floor()
   endRow = ((rect.bottom - minY) / gridSize).floor()
   ```

2. Check only against rectangles in those cells
   ```
   for col in startCol to endCol:
     for row in startRow to endRow:
       index = row * gridWidth + col
       check against rectangles in spatialIndex[index]
   ```

This limits collision checks to only the relevant portion of the canvas.

---
EACH CELL

Yes, exactly! Each cell in the spatial index can (and often will) contain multiple rectangles. This is a key aspect of how the spatial index works:

1. Each cell represents a specific region of the canvas
2. Any rectangle that overlaps with that region is added to that cell's list
3. A cell can contain:
   - Zero rectangles (empty space)
   - One rectangle
   - Multiple rectangles (where words are densely packed)

For example, in a dense part of the word cloud, a single cell might contain references to 10-15 different word rectangles that all overlap with that region of the canvas.

When checking for collisions, you only need to check against the rectangles in the cells that your new rectangle would occupy. This is much more efficient than checking against all rectangles in the entire canvas.

The spatial index essentially maps from "location in space" to "objects at that location," allowing for efficient spatial queries.


