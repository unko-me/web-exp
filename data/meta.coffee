BASE_DATA =
  url: 'http://unko-me.github.io/web-exp/'
  title: 'UNKO.ME Experiments'
  description: "Experiments of UNKO.ME"
  keywords: "unkoと言っていればウケると思っている"
  share: "このサイトはunko.meが作っています"

module.exports = exports =

  BASE_DATA: BASE_DATA

  sns:
    twitter:
      lang: 'ja'
      hashtags: 'unko.me'
      text: BASE_DATA.share
      domain: "unko-me.github.io"
      site: "@katapad"
      card: "summary_large_image"
    fb:
      app_id: 'xxxxxxxxxxx'
    line:
      text: BASE_DATA.share
      link: BASE_DATA.url
    og:
      locale: 'ja_JP'
      image: [
        'http://unko.me/img/ogp_logo.png'
      ]
      type: 'website'
      site_name: BASE_DATA.title
      title: BASE_DATA.description
      description: BASE_DATA.keywords
      url: BASE_DATA.url
