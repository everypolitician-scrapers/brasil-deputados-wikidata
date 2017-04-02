#!/bin/env ruby
# encoding: utf-8

require 'wikidata/fetcher'

directora_55 = EveryPolitician::Wikidata.wikipedia_xpath(
  url: 'https://pt.wikipedia.org/wiki/Lista_de_deputados_federais_do_Brasil_da_55.ª_legislatura',
  after: '//span[@id="Mesa_Diretora"]',
  before: '//span[@id=".C2.A0Acre"]',
  xpath: '//table//td[3]//a[not(@class="new")]/@title',
)

by_area_55 = EveryPolitician::Wikidata.wikipedia_xpath(
  url: 'https://pt.wikipedia.org/wiki/Lista_de_deputados_federais_do_Brasil_da_55.ª_legislatura',
  after: '//span[@id=".C2.A0Acre"]',
  before: '//span[@id="Licen.C3.A7as"]',
  xpath: '//table//td[1]//a[not(@class="new")]/@title',
)

licencas_55 = EveryPolitician::Wikidata.wikipedia_xpath(
  url: 'https://pt.wikipedia.org/wiki/Lista_de_deputados_federais_do_Brasil_da_55.ª_legislatura',
  after: '//span[@id="Licen.C3.A7as"]',
  before: '//span[@id="Ver_tamb.C3.A9m"]',
  xpath: '//table//td[2]//a[not(@class="new")]/@title',
)

directora_54 = EveryPolitician::Wikidata.wikipedia_xpath(
  url: 'https://pt.wikipedia.org/wiki/Lista_de_deputados_federais_do_Brasil_da_54.ª_legislatura',
  after: '//span[@id="Mesa_Diretora"]',
  before: '//span[@id=".C2.A0Acre"]',
  xpath: '//table//td[3]//a[not(@class="new")]/@title',
)

by_area_54 = EveryPolitician::Wikidata.wikipedia_xpath(
  url: 'https://pt.wikipedia.org/wiki/Lista_de_deputados_federais_do_Brasil_da_54.ª_legislatura',
  after: '//span[@id=".C2.A0Acre"]',
  before: '//span[@id="Licen.C3.A7as"]',
  xpath: '//table//td[1]//a[not(@class="new")]/@title',
)

# Find all P39s of the 54th & 55th Term
query = <<EOS
  SELECT DISTINCT ?item
  WHERE
  {
    VALUES ?membership { wd:Q20058725 }
    VALUES ?term { wd:Q4640499 wd:Q18479094 }

    ?item p:P39 ?position_statement .
    ?position_statement ps:P39 ?membership .
    ?position_statement pq:P2937 ?term .
  }
EOS
p39s = EveryPolitician::Wikidata.sparql(query)

EveryPolitician::Wikidata.scrape_wikidata(ids: p39s, names: { pt: directora_55 | by_area_55 | licencas_55 | directora_54 | by_area_54 })
