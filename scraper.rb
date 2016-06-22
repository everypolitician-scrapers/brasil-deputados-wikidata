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
  before: '//span[@id="Afastados"]',
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

EveryPolitician::Wikidata.scrape_wikidata(names: { pt: directora_55 | by_area_55 | licencas_55 | directora_54 | by_area_54 })
