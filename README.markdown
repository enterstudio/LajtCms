# LajtCMS (aka Basic CMS)

Bardzo prosty CMS dla statycznych stron (zintegrowana obsługa wielu języków [domyślnie PL, EN, DE])
Posiada on część administracyjna dla stron statycznych i załączników.

Załączniki mogą zostać wywołane za pomocą specjalnych tagów w stronach statycznych (dzięki Radius-owi)

## Tagi

LajtCMS używa zmienionej wersji systemu templatek jakim jest Radius (http://github.com/manuelmeurer/radius/).  
Następujące tagi zostały już zdefiniowane.

`<r:asset id="42" [show="link|url|image"] [size="original|large|medium|thumb"] [more="attributes"] />`

Pokazuje załącznik ID 42.
Atrybut "show" określa typ tego co ma zostać pokazane (standardowo link).
Atrybut "size" określa rozmiar obrazka (rozmiary są zdefiniowane w pliku config.yml, standardowo 'original')
Wszystkie dodatkowe atrybuty zostaną automatycznie wrzucone w tag html.

## Konfiguracja

Cała konfiguracja aplikacji znajduje się w pliku config/app_config.yml.
Możesz w niej zmienić następujące rzeczy:

* Języki
Strony statyczne mają oddzielne pola w bazie dla każdego języka.
Język będzie pierwszym parametrem w adresie URL, np. http://lajtcms.com/pl/start dla polskiej wersji strony 'start'.
Pierwszy język na liście zostanie automatycznie ustawiony językiem domyślnym.

* Rozmiary obrazków
Ustalasz rozmiary wgrywanego obrazka.
Wyciąg z dokumentacji Paperclip:
"You can find more about geometry strings at the [ImageMagick website](http://www.imagemagick.org/script/command-line-options.php#resize). Paperclip also adds the '#' option (e.g. "50x50#"), which will resize the image to fit maximally inside the dimensions and then crop the rest off (weighted at the center)."

## Wymagania

### Radius
http://github.com/manuelmeurer/radius/

### ImageMagick

Zmiana rozmiarów obrazków jest wykonywana za pomocą ImageMagick
Przejdź do [ImageMagick website](http://www.imagemagick.org) po instrukcje instalacji.

### Gemy

* Paperclip (v2.2.5)
* RDiscount (v1.3.1.1)
* Haml (v2.0.6)
* Radius (v0.6.0, modified, from <http://github.com/manuelmeurer/radius/>)
* will_paginate (v2.3.8)

Następujące gemy są wymagane do poprawneo działania aplikacji. Nie ma wśród nich gemu 'Radius', który to trzeba zainstalować oddzielnie.
Instalujesz je komendą

`rake gems:install`

uruchamianą z poziomu katalogu 'lajtcms'.


## Użyte pluginy

* acts_as_tree

## CSS

* Bluescreen CSS (v0.8)

## Javascript

* jQuery (v1.3.1)

## Submodules

* Radius (http://github.com/manuelmeurer/radius)

## Icons

[Famfamfam Silk Icons](http://www.famfamfam.com/lab/icons/silk/)

## Ernest Bursa Dzikidzik.org
## Fork of http://github.com/tweak/basic_cms/
