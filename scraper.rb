#!/bin/env ruby
# encoding: utf-8

require 'wikidata/fetcher'

directora_55 = EveryPolitician::Wikidata.wikipedia_xpath(
  url: 'https://pt.wikipedia.org/wiki/Lista_de_deputados_federais_do_Brasil_da_55.ª_legislatura',
  after: '//span[@id="Mesa_diretora"]',
  before: '//span[@id="Por_unidade_da_federação"]',
  xpath: '//table//td[3]//a[not(@class="new")]/@title',
)

by_area_55 = EveryPolitician::Wikidata.wikipedia_xpath(
  url: 'https://pt.wikipedia.org/wiki/Lista_de_deputados_federais_do_Brasil_da_55.ª_legislatura',
  after: '//span[@id="Por_unidade_da_federação"]',
  before: '//span[@id="Renúncias"]',
  xpath: '//table//td[1]//a[not(@class="new")]/@title',
)

licencas_55 = EveryPolitician::Wikidata.wikipedia_xpath(
  url: 'https://pt.wikipedia.org/wiki/Lista_de_deputados_federais_do_Brasil_da_55.ª_legislatura',
  after: '//span[@id="Renúncias"]',
  before: '//span[@id="Ver_também"]',
  xpath: '//table//td[2]//a[not(@class="new")]/@title',
)

directora_54 = EveryPolitician::Wikidata.wikipedia_xpath(
  url: 'https://pt.wikipedia.org/wiki/Lista_de_deputados_federais_do_Brasil_da_54.ª_legislatura',
  after: '//span[@id="Mesa_Diretora"]',
  before: '//span[@id="_Acre"]',
  xpath: '//table//td[3]//a[not(@class="new")]/@title',
)

by_area_54 = EveryPolitician::Wikidata.wikipedia_xpath(
  url: 'https://pt.wikipedia.org/wiki/Lista_de_deputados_federais_do_Brasil_da_54.ª_legislatura',
  after: '//span[@id="_Acre"]',
  before: '//span[@id="Licenças"]',
  xpath: '//table//td[1]//a[not(@class="new")]/@title',
)

# Find all P39s of the 54th & 55th Term
query = <<EOS
  SELECT DISTINCT ?item WHERE {
    ?item p:P39 [ ps:P39/wdt:P279* wd:Q20058725 ; pq:P2937 ?term ].
    ?term p:P31/pq:P1545 ?ordinal FILTER (xsd:integer(?ordinal) >= 54)
  }
EOS
p39s = EveryPolitician::Wikidata.sparql(query)

EveryPolitician::Wikidata.scrape_wikidata(ids: p39s, names: { pt: directora_55 | by_area_55 | licencas_55 | directora_54 | by_area_54 })
