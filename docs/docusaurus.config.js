/** @type {import('@docusaurus/types').DocusaurusConfig} */
module.exports = {
    title: 'Linwood Flow Docs',
    tagline: 'A feature rich event and time managment system',
    url: 'https://docs.flow.linwood.dev',
    baseUrl: '/',
    onBrokenLinks: 'throw',
    onBrokenMarkdownLinks: 'warn',
    favicon: 'img/favicon.ico',
    organizationName: 'LinwoodCloud', // Usually your GitHub org/user name.
    projectName: 'Flow', // Usually your repo name.
    themeConfig: {
        navbar: {
            title: 'Linwood Flow',
            logo: {
                alt: 'Linwood Flow Logo',
                src: 'img/logo.svg',
            },
            items: [
                {
                    type: 'doc',
                    docId: 'intro',
                    position: 'left',
                    label: 'Tutorial',
                },
                {
                    to: 'downloads',
                    label: 'Downloads',
                    position: 'left'
                },
                {
                    type: 'dropdown',
                    label: 'More',
                    position: 'left',
                    items: [
                        {
                            label: 'Matrix',
                            href: 'https://linwood.dev/matrix',
                        },
                        {
                            label: 'Discord',
                            href: 'https://discord.linwood.dev',
                        },
                        {
                            label: 'GitHub',
                            href: 'https://github.com/LinwoodCloud/Butterfly',
                        },
                        {
                            label: 'Blog', 
                            href: 'https://linwood.dev/blog'
                        },
                        {
                            label: 'Crowdin',
                            href: 'https://go.linwood.dev/butterfly/crowdin'
                        },
                        {
                            label: 'Twitter',
                            href: 'https://twitter.com/LinwoodCloud',
                        },
                        {
                            label: 'Mastodon',
                            href: 'https://floss.social/@linwood',
                        },
                        {
                            label: 'License',
                            href: 'https://go.linwood.dev/butterfly/license',
                        }
                    ],
                },
            ],
        },
        footer: {
            style: 'dark',
            links: [
                {
                    title: 'Community',
                    items: [
                        {
                            label: 'Discord',
                            href: 'https://discord.linwood.dev',
                        },
                        {
                            label: 'Matrix',
                            href: 'https://linwood.dev/matrix',
                        },
                        {
                            label: 'Twitter',
                            href: 'https://twitter.com/LinwoodCloud',
                        },
                        {
                            label: 'Mastodon',
                            href: 'https://floss.social/@linwood',
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
                    title: 'Source code',
                    items: [
                        {
                            label: 'App',
                            href: 'https://github.com/LinwoodCloud/Flow/tree/develop/app',
                        },
                        {
                            label: 'Server',
                            href: 'https://github.com/LinwoodCloud/Flow/tree/develop/server',
                        },
                        {
                            label: 'Docs',
                            href: 'https://github.com/LinwoodCloud/Flow/tree/develop/docs',
                        },
                        {
                            label: 'Shared',
                            href: 'https://github.com/LinwoodCloud/Flow/tree/develop/shared',
                        },
                        {
                            label: 'Contribution guide',
                            href: 'https://github.com/LinwoodCloud/butterfly/blob/develop/CONTRIBUTING.md',
                        },
                    ],
                },
                {
                    title: 'Legal',
                    items: [
                        {
                            label: 'Imprint',
                            to: 'https://codedoctor.tk/impress',
                        },
                        {
                            label: 'Privacy Policy',
                            href: 'https://codedoctor.tk/privacy',
                        },
                    ],
                }
            ],
            // Please do not remove the credits, help to publicize Docusaurus :)
            copyright: `Copyright © ${new Date().getFullYear()} LinwoodCloud.`,
        },
    },
    presets: [
        [
            '@docusaurus/preset-classic',
            {
                docs: {
                    sidebarPath: require.resolve('./sidebars.js'),
                    // Please change this to your repo.
                    editUrl:
                        'https://github.com/LinwoodCloud/Flow/edit/develop/docs/',
                },
                blog: false,
                theme: {
                    customCss: require.resolve('./src/css/custom.css'),
                },
            },
        ],
    ],
};
