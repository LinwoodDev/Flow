// @ts-check
import { defineConfig } from "astro/config";
import starlight from "@astrojs/starlight";

// https://astro.build/config
export default defineConfig({
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
          label: "Guides",
          items: [
            // Each item here is one entry in the navigation menu.
            { label: "Intro", slug: "docs/v1/intro" },
          ],
        },
      ],
    }),
  ],
});
