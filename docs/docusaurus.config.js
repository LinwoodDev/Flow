/** @type {import('@docusaurus/types').DocusaurusConfig} */
module.exports = {
  title: "Linwood Flow",
  tagline: "A feature rich event and time managment system",
  url: "https://docs.flow.linwood.dev",
  baseUrl: "/",
  onBrokenLinks: "throw",
  onBrokenMarkdownLinks: "warn",
  favicon: "img/favicon.ico",
  organizationName: "LinwoodDev", // Usually your GitHub org/user name.
  projectName: "Flow", // Usually your repo name.
  i18n: {
    defaultLocale: "en",
    locales: ["en", "de", "fr", "es", "it", "pt-br", "th", "tr", "ru"],
  },
  themeConfig: {
    colorMode: {
      defaultMode: "dark",
      disableSwitch: false,
      respectPrefersColorScheme: true,
    },
    navbar: {
      title: "Flow",
      logo: {
        alt: "Flow Logo",
        src: "img/logo.svg",
      },
      items: [
        {
          type: "doc",
          docId: "intro",
          position: "left",
          label: "Tutorial",
        },
        {
          to: "downloads",
          label: "Downloads",
          position: "left",
        },
        {
          type: "doc",
          docId: "community",
          docsPluginId: "community",
          position: "left",
          label: "Community",
        },
        {
          type: "dropdown",
          label: "More",
          position: "left",
          items: [
            {
              label: "Matrix",
              href: "https://linwood.dev/matrix",
            },
            {
              label: "Discord",
              href: "https://discord.linwood.dev",
            },
            {
              label: "GitHub",
              href: "https://github.com/LinwoodDev/Flow",
            },
            {
              label: "Blog",
              href: "https://linwood.dev/blog",
            },
            {
              label: "Crowdin",
              href: "https://go.linwood.dev/flow/crowdin",
            },
            {
              label: "Twitter",
              href: "https://twitter.com/LinwoodDev",
            },
            {
              label: "Masnoten",
              href: "https://floss.social/@linwood",
            },
            {
              label: "License",
              href: "https://go.linwood.dev/flow/license",
            },
          ],
        },
        {
          type: "localeDropdown",
          position: "right",
          dropdownItemsAfter: [
            {
              to: "https://translate.linwood.dev/flow",
              label: "Help translate",
            },
          ],
        },
      ],
    },
    footer: {
      style: "dark",
      links: [
        {
          title: "Community",
          items: [
            {
              label: "Discord",
              href: "https://discord.linwood.dev",
            },
            {
              label: "Matrix",
              href: "https://linwood.dev/matrix",
            },
            {
              label: "Twitter",
              href: "https://twitter.com/LinwoodDev",
            },
            {
              label: "Masnoten",
              href: "https://floss.social/@linwood",
            },
            {
              html: `
                <a href="https://vercel.com?utm_source=Linwood&utm_campaign=oss" target="_blank" rel="noreferrer noopener" aria-label="Deploys by Vercel">
                  <img src="/img/powered-by-vercel.svg" alt="Deploys by Vercel" />
                </a>
              `,
            },
          ],
        },
        {
          title: "Source code",
          items: [
            {
              label: "App",
              href: "https://github.com/LinwoodDev/Flow/tree/develop/app",
            },
            {
              label: "Server",
              href: "https://github.com/LinwoodDev/Flow/tree/develop/server",
            },
            {
              label: "Docs",
              href: "https://github.com/LinwoodDev/Flow/tree/develop/docs",
            },
            {
              label: "Shared",
              href: "https://github.com/LinwoodDev/Flow/tree/develop/shared",
            },
            {
              label: "Contribution guide",
              href: "https://github.com/LinwoodDev/Flow/blob/develop/CONTRIBUTING.md",
            },
          ],
        },
        {
          title: "Legal",
          items: [
            {
              label: "Imprint",
              href: "https://go.linwood.dev/imprint",
            },
            {
              label: "Privacy Policy of the app",
              href: "/privacypolicy",
            },
            {
              label: "Privacy Policy of the website",
              href: "https://go.linwood.dev/privacypolicy",
            },
          ],
        },
      ],
      logo: {
        alt: "Linwood Logo",
        src: "https://raw.githubusercontent.com/LinwoodDev/website/main/public/logos/logo.png",
        width: 100,
        href: "https://linwood.dev",
      },
      copyright: `Copyright © ${new Date().getFullYear()} LinwoodDev.`,
    },
  },
  presets: [
    [
      "@docusaurus/preset-classic",
      {
        docs: {
          sidebarPath: require.resolve("./sidebars.js"),
          // Please change this to your repo.
          editUrl: "https://github.com/LinwoodDev/Flow/edit/develop/docs/",
        },
        blog: false,
        theme: {
          customCss: require.resolve("./src/css/custom.css"),
        },
      },
    ],
  ],
  plugins: [
    [
      "@docusaurus/plugin-content-docs",
      {
        id: "community",
        path: "community",
        routeBasePath: "/",
        sidebarPath: require.resolve("./sidebarsCommunity.js"),
      },
    ],
    [
      "@docusaurus/plugin-pwa",
      {
        offlineModeActivationStrategies: [
          "appInstalled",
          "standalone",
          "queryString",
        ],
        pwaHead: [
          {
            tagName: "link",
            rel: "icon",
            href: "/img/logo.png",
          },
          {
            tagName: "link",
            rel: "manifest",
            href: "/manifest.json", // your PWA manifest
          },
          {
            tagName: "meta",
            name: "theme-color",
            content: "#7c4dff",
          },
        ],
      },
    ],
    // Other tweaks
  ],
};
