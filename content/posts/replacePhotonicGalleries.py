#!/bin/python
# Dateiname definieren
filename = "index.md"

# Ersatztext definieren
replacement = "REPLACED TEXT"

# Öffnen Sie die Datei im Lesemodus
with open(filename, "r") as file:
    # Lesen Sie den Inhalt der Datei
    content = file.read()
with open(filename+"-backup", "w") as file:
    file.write(content)

# Verwenden Sie re.sub(), um den Text zu ersetzen
lastMatch = 0
beginMarker = "<div class='photonic-google-stream photonic-stream '"
endMarker = "<!-- .photonic-stream or .photonic-panel -->"
replaceWith = "{{{{< gallery match=\"images/Koh Tao - Tioman {}/*\" >}}}}"
newContent = ""
end = len(content)
nextGallery = 1
while(lastMatch != -1):
    start = content.find(beginMarker, lastMatch)
    if(start == -1):
        break;
    end = content.index(endMarker, start)
    newContent += content[lastMatch:start]
    newContent += replaceWith.format(nextGallery)
    nextGallery = nextGallery + 1 
    lastMatch = end + len(endMarker)
newContent+=content[lastMatch:]

# Öffnen Sie die Datei im Schreibmodus
with open(filename, "w") as file:
    # Schreiben Sie den neuen Inhalt in die Datei
   file.write(newContent)
