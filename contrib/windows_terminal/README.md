# Lavi for Windows Terminal

<a href="https://github.com/microsoft/terminal">Windows Terminal</a>: Modern terminal application for Windows

## Installation

1. Open the Windows Terminal settings (`ctrl+,`)
2. Select **Open JSON file** at the bottom left corner (`ctrl+shift+,`)
3. Copy the contents of [`lavi.json`](./lavi.json) inside of the `schemes` array
   ```jsonc
   {
     "schemes": [
       // paste the contents of lavi.json here
     ],
   }
   ```
4. Save and exit
5. In the **Settings** panel under **Profiles**, select the profile you want to use the theme in, then select **Appearance** and choose **lavi** from the **Color scheme** dropdown

---

Part of [Lavi](https://github.com/b0o/lavi), a soft and sweet colorscheme.
