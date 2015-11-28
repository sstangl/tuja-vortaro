all: dictionaries

dictionaries:
	$(MAKE) -C espdic
	$(MAKE) -C etymology
	$(MAKE) -C revo
	$(MAKE) -C transitiveco

clean:
	$(MAKE) -C espdic clean
	$(MAKE) -C etymology clean
	$(MAKE) -C revo clean
	$(MAKE) -C transitiveco clean
