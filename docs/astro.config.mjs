// @ts-check
import { defineConfig } from "astro/config";
import { getSidebarTranslatedLabel } from "./src/translations";
import starlight from "@astrojs/starlight";
// @ts-ignore
import remarkHeadingID from "remark-heading-id";
import remarkGemoji from "remark-gemoji";

// https://astro.build/config
export default defineConfig({
  site: "https://flow.linwood.dev",
  markdown: {
    remarkPlugins: [remarkHeadingID, remarkGemoji],
  },
  integrations: [
    starlight({
      title: "Linwood Flow",
      customCss: [
        // Relative path to your custom CSS file
        "./src/styles/custom.css",
      ],
      logo: {
        src: "./public/img/docs.svg",
      },
      favicon: "./favicon.ico",
      social: {
        mastodon: "https://floss.social/@linwood",
        matrix: "https://linwood.dev/matrix",
        discord: "https://linwood.dev/discord",
        github: "https://github.com/LinwoodDev/Flow",
      },
      components: {
        SocialIcons: "./src/components/CustomSocialIcons.astro",
        Head: "./src/components/Head.astro",
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
  ],
});
