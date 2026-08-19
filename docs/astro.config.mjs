import { defineConfig } from "astro/config";
import starlight from "@astrojs/starlight";
import react from "@astrojs/react";
import { getSidebarTranslatedLabel } from "./src/translations";
import AstroPWA from "@vite-pwa/astro";
import manifest from "./webmanifest.json";
import { fileURLToPath } from "node:url";
import { satteri } from "@astrojs/markdown-satteri";

const githubEmoji = {
  warning: "⚠️",
  white_check_mark: "✅",
  x: "❌",
};

const renderGithubEmojiPlugin = {
  name: "render-github-emoji",
  text(node, context) {
    const value = node.value.replace(
      /:(warning|white_check_mark|x):/g,
      (_, name) => githubEmoji[name],
    );
    if (value !== node.value) context.replaceNode(node, { type: "text", value });
  },
};

const mdxHeadingAttributes = {
  name: "mdx-heading-attributes",
  enforce: "pre",
  transform(code, id) {
    if (!id.split("?", 1)[0].endsWith(".mdx")) return;
    const transformed = code.replace(
      /^(#{1,6})\s+(.+?)\s+\{#([\w-]+)\}\s*$/gm,
      (_, hashes, heading, headingId) =>
        `<h${hashes.length} id="${headingId}">${heading}</h${hashes.length}>`,
    );
    if (transformed === code) return;
    return { code: transformed, map: null };
  },
};

// https://astro.build/config
export default defineConfig({
  site: "https://flow.linwood.dev",
  markdown: {
    processor: satteri({
      features: { headingAttributes: true },
      mdastPlugins: [renderGithubEmojiPlugin],
    }),
  },
  vite: {
    plugins: [mdxHeadingAttributes],
  },
  integrations: [
    starlight({
      title: "Linwood Flow",
      customCss: [
        "./src/styles/linwood-style.scss",
        "./src/styles/custom.scss",
      ],
      editLink: {
        baseUrl: 'https://github.com/LinwoodDev/Flow/edit/develop/docs/',
      },
      logo: {
        src: "./public/img/docs.svg",
      },
      favicon: "./favicon.svg",
      social: [
        { icon: "mastodon", label: "Mastodon", href: "https://floss.social/@linwood" },
        { icon: "matrix", label: "Matrix", href: "https://linwood.dev/matrix" },
        { icon: "discord", label: "Discord", href: "https://linwood.dev/discord" },
        { icon: "blueSky", label: "Bluesky", href: "https://bsky.app/profile/linwood.dev" },
        { icon: "github", label: "GitHub", href: "https://github.com/LinwoodDev/Flow" },
      ],
      components: {
        Head: "./src/components/Head.astro",
        Search: "./src/components/Search.astro",
        Footer: "./src/components/Footer.astro",
        ContentPanel: "./src/components/ContentPanel.astro",
      },
      sidebar: [
        {
          ...getSidebarTranslatedLabel("Guides"),
          items: [
            {
              ...getSidebarTranslatedLabel("Introduction"),
              link: "/docs/v1/intro",
            },
          ],
        },
        {
          ...getSidebarTranslatedLabel("Downloads"),
          link: "/downloads/",
        },
        {
          ...getSidebarTranslatedLabel("Community"),
          items: [
            {
              ...getSidebarTranslatedLabel("Home"),
              link: "/community/",
            },
            {
              ...getSidebarTranslatedLabel("Branding"),
              link: "/community/branding/",
            },
            {
              ...getSidebarTranslatedLabel("Changelog"),
              link: "/changelog/",
            },
            {
              ...getSidebarTranslatedLabel("Contributing"),
              link: "/community/contributing/",
            },
            {
              ...getSidebarTranslatedLabel("Code of conduct"),
              link: "/community/code-of-conduct/",
            },
            {
              ...getSidebarTranslatedLabel("FAQ"),
              link: "/community/faq/",
            },
            {
              ...getSidebarTranslatedLabel("Versions"),
              link: "/community/versions/",
            },
            {
              ...getSidebarTranslatedLabel("Nightly builds"),
              link: "/community/nightly/",
            },
            {
              ...getSidebarTranslatedLabel("Privacy policy"),
              link: "/privacypolicy/",
            },
          ],
        },
      ],
      locales: {
        root: {
          label: "English",
          lang: "en",
        },
        af: {
          label: "Afrikaans",
        },
        ar: {
          label: "Arabic",
        },
        ca: {
          label: "Catalan",
        },
        cs: {
          label: "Czech",
        },
        da: {
          label: "Danish",
        },
        de: {
          label: "German",
        },
        el: {
          label: "Greek",
        },
        es: {
          label: "Spanish",
        },
        fi: {
          label: "Finnish",
        },
        fr: {
          label: "French",
        },
        he: {
          label: "Hebrew",
        },
        hi: {
          label: "Hindi",
        },
        hu: {
          label: "Hungarian",
        },
        id: {
          label: "Indonesian",
        },
        it: {
          label: "Italian",
        },
        ja: {
          label: "Japanese",
        },
        ko: {
          label: "Korean",
        },
        nl: {
          label: "Dutch",
        },
        no: {
          label: "Norwegian",
        },
        or: {
          label: "Oriya",
        },
        pl: {
          label: "Polish",
        },
        pt: {
          label: "Portuguese",
        },
        "pt-br": {
          label: "Portuguese (Brazil)",
          lang: "pt-BR",
        },
        ro: {
          label: "Romanian",
        },
        ru: {
          label: "Russian",
        },
        sr: {
          label: "Serbian",
        },
        sv: {
          label: "Swedish",
        },
        th: {
          label: "Thai",
        },
        tr: {
          label: "Turkish",
        },
        uk: {
          label: "Ukrainian",
        },
        vi: {
          label: "Vietnamese",
        },
        zh: {
          label: "Chinese",
        },
        "zh-hant": {
          label: "Chinese (Traditional)",
          lang: "zh-Hant",
        },
      },
    }),
    AstroPWA({
      workbox: {
        skipWaiting: true,
        clientsClaim: true,
        navigateFallback: "/404",
        ignoreURLParametersMatching: [/./],
        globPatterns: [
          "**/*.{html,js,css,png,svg,json,ttf,pf_fragment,pf_index,pf_meta,pagefind,wasm}",
        ],
      },
      experimental: {
        directoryAndTrailingSlashHandler: true,
      },
      registerType: "autoUpdate",
      manifest,
    }),
    react(),
  ],
});
