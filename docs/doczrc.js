import images from 'remark-images'
import emoji from 'remark-emoji'

export default {
    files: '**/*.{md,markdown,mdx}',
    title: 'Humble documentation',
    mdPlugins: [images, emoji],
}
