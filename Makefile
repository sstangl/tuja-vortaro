all: espdic/espdic.js etymology/etymology.js transitiveco/transitiveco.js

espdic/espdic.js:
	$(MAKE) -C espdic

etymology/etymology.js:
	$(MAKE) -C etymology

transitiveco/transitiveco.js:
	$(MAKE) -C transitiveco

clean:
	$(MAKE) -C espdic clean
	$(MAKE) -C etymology clean
	$(MAKE) -C transitiveco clean
