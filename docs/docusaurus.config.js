/** @type {import('@docusaurus/types').DocusaurusConfig} */
module.exports = {
    title: 'Linwood Flow Docs',
    tagline: 'A feature rich event and time managment system',
    url: 'https://docs.flow.linwood.tk',
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
                {href: 'https://linwood.tk/blog', label: 'Blog', position: 'left'},
                {
                    href: 'https://github.com/LinwoodCloud/Flow',
                    label: 'GitHub',
                    position: 'right',
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
                            href: 'https://discord.linwood.tk',
                        },
                        {
                            label: 'Twitter',
                            href: 'https://twitter.com/LinwoodCloud',
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
                        }
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
