# guideline_email_template

## Email-safe habit
Because of those quirks, the safest pattern is:

Structural width → on <table>

Visual styles (bg, padding, borders) → on <td>


## G2

Border-radius → put on <table> (so it affects the whole card shape).

Background color, padding, borders → put on <td> (most reliable across email clients).


## E3

For email HTML templates, even when creating a card via table, background-color and padding should still go on the `td`. This is a well-established pattern for maximum email client compatibility. So:

- `table`: border-radius, width, margin
- `td`: background-color, padding

This separation has proven to be most reliable across different email clients.


## Div Equivalent

Yep — for the “blank container” equivalent of a `<div>` in email HTML, the usual safe base looks like:

```html
<table cellspacing="0" cellpadding="0" border="0" width="100%">
  <tr>
    <td>
      <!-- your content here -->
    </td>
  </tr>
</table>
```

**Why each part is there**:

* `cellspacing="0"` → removes gaps between cells.
* `cellpadding="0"` → removes the default padding inside each `<td>`.
* `border="0"` → removes default table border in some clients.
* `width="100%"` → makes it span the full available width (like `width: 100%` on a `<div>`).

Then you style the `<td>` for padding, background, border-radius, etc.
In email templates, we avoid relying only on CSS for layout — so these attributes are kept for maximum compatibility.

If you want, I can give you a **minimal “card” skeleton** using this safe base.
