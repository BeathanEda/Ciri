zotero_extension_source_dir := "/var/lib/flatpak/app/org.zotero.Zotero/current/active/files/share/zotero/integration/libreoffice"
unopkg_path := "/app/libreoffice/program/unopkg"

setup-writer-toolbox:
	flatpak install -y --system flathub org.libreoffice.LibreOffice
	flatpak install -y --system flathub org.zotero.Zotero

	cp {{zotero_extension_source_dir}}/Zotero_LibreOffice_Integration.oxt "{{home_dir()}}/Zotero_LibreOffice_Integration.oxt"
	
	flatpak run --command=sh org.libreoffice.LibreOffice -c \
	'{{unopkg_path}} list | grep -q "org.Zotero.integration.openoffice" || {{unopkg_path}} add "$HOME/Zotero_LibreOffice_Integration.oxt"'

	rm "{{home_dir()}}/Zotero_LibreOffice_Integration.oxt"

remove-writer-toolbox:
	flatpak remove -y org.libreoffice.LibreOffice
	flatpak remove -y org.zotero.Zotero

	flatpak run --command=sh org.libreoffice.LibreOffice -c \
	'{{unopkg_path}} list | grep -q "org.Zotero.integration.openoffice" && {{unopkg_path}} remove org.Zotero.integration.openoffice'
