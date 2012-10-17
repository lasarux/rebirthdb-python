VERBOSE?=0

ifeq ($(VERBOSE),1)
QUIET:=
else
QUIET:=@
endif

SOURCE_DIR?=../../src
PYTHON_PBDIR:=../../build/drivers/python
PYTHON_PBFILE:=query_language_pb2.py
RUBY_PBDIR:=../../build/drivers/ruby
RUBY_PBFILE:=query_language.pb.rb
BUILD_DRIVERS?=1
PROTOCFLAGS:= --proto_path=$(SOURCE_DIR)
all: driver-python
$(PYTHON_PBDIR):
	$(QUIET) mkdir -p $(PYTHON_PBDIR)

driver-python: $(PYTHON_PBDIR)/rdb_protocol/$(PYTHON_PBFILE)
PROTOFILE:=$(SOURCE_DIR)/rdb_protocol/query_language.proto
PROTOPATH:=$(SOURCE_DIR)/rdb_protocol
$(PYTHON_PBDIR)/rdb_protocol/$(PYTHON_PBFILE): $(PYTHON_PBDIR) $(PROTOFILE)
ifeq ($(VERBOSE),0)
	@echo "    PROTOC[PY] $(PROTOFILE)"
endif
	$(QUIET) protoc $(PROTOCFLAGS) --python_out $(PYTHON_PBDIR) $(PROTOFILE)

clean:
ifeq ($(VERBOSE),0)
        @echo "    RM $(PYTHON_PBDIR)/rdb_protocol/$(PYTHON_PBFILE)"
endif
	$(QUIET) if [ -e $(PYTHON_PBDIR)/rdb_protocol/$(PYTHON_PBFILE) ] ; then rm $(PYTHON_PBDIR)/rdb_protocol/$(PYTHON_PBFILE) ; fi ;
