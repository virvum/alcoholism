.ONESHELL:

.PHONY: deploy
deploy:
	npm run build
	scp -r dist iperyt:/tmp
	cat <<'EOF' | ssh iperyt
	sudo cp -r /tmp/dist/* /var/www/fucklife.ch/htdocs
	sudo chown -R www:www /var/www/fucklife.ch/htdocs
	sudo rm -rf /tmp/dist
	EOF
