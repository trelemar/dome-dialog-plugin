#include <stddef.h>
#include <stdlib.h>
#include <stdio.h>
#include <stdint.h>
#include <string.h>

#include "dome.h"
#include "lib/tinyfiledialogs.h"
#include "dialog.c.inc"

#ifdef _MSC_VER
#pragma warning(disable:4996) /* silences warnings about strcpy strcat fopen*/
#endif


static DOME_API_v0* core;
static WREN_API_v0* wren;
//static IO_API_v0* io;

void DIALOG_allocate(WrenVM* vm) {
  size_t CLASS_SIZE = 0; // This should be the size of your object's data
  void* obj = wren->setSlotNewForeign(vm, 0, 0, CLASS_SIZE);
}


void DIALOG_messageBox(WrenVM* vm) {
  const char* title = wren->getSlotString(vm, 1);
  const char* message = wren->getSlotString(vm, 2);
  const char* type = wren->getSlotString(vm, 3);
  const char* icon = wren->getSlotString(vm, 4);
  int output = tinyfd_messageBox(title, message, type, icon, 1);
  wren->setSlotDouble(vm, 0, output);
}

void DIALOG_inputBox(WrenVM* vm) {
  const char* title = wren->getSlotString(vm, 1);
  const char* message = wren->getSlotString(vm, 2);
  const char* input = wren->getSlotString(vm, 3);
  const char* output = tinyfd_inputBox(title, message, input);
  if (output != NULL) {wren->setSlotString(vm, 0, output);}
  else {wren->setSlotNull(vm, 0);}
}

void DIALOG_saveFile(WrenVM* vm) {
  wren->ensureSlots(vm, 5);
  const char* title = wren->getSlotString(vm, 1);
  const char* path = wren->getSlotString(vm, 2);

  char const * filterPatterns[10] = {};
  int filterCount = wren->getListCount(vm, 3);

  const char* filterDescription = wren->getSlotString(vm, 4);

  for (int i = 0; i < filterCount; i++) {
    wren->getListElement(vm, 3, i, 5);
    filterPatterns[i] = wren->getSlotString(vm, 5);
  }

  char* outpath = tinyfd_saveFileDialog(title, path, filterCount, filterPatterns, filterDescription);
  if (outpath != NULL) {wren->setSlotString(vm, 0, outpath);}
  else {wren->setSlotNull(vm, 0);}
}

void DIALOG_openFile(WrenVM* vm) {
  wren->ensureSlots(vm, 5);
  const char* title = wren->getSlotString(vm, 1);
  const char* path = wren->getSlotString(vm, 2);

  char const * filterPatterns[10] = {};
  int filterCount = wren->getListCount(vm, 3);

  const char* filterDescription = wren->getSlotString(vm, 4);

  for (int i = 0; i < filterCount; i++) {
    wren->getListElement(vm, 3, i, 5);
    filterPatterns[i] = wren->getSlotString(vm, 5);
  }

  char* outpath = tinyfd_openFileDialog(title, path, filterCount, filterPatterns, filterDescription, 0);
  if (outpath != NULL) {wren->setSlotString(vm, 0, outpath);}
  else {wren->setSlotNull(vm, 0);}
}

void DIALOG_selectFolder(WrenVM* vm) {
  const char* title = wren->getSlotString(vm, 1);
  const char* path = wren->getSlotString(vm, 2);
  char* outpath = tinyfd_selectFolderDialog(title, path);
  if (outpath != NULL) {wren->setSlotString(vm, 0, outpath);}
  else {wren->setSlotNull(vm, 0);}
}

void DIALOG_colorPicker(WrenVM* vm){
  const char* title = wren->getSlotString(vm, 1);
  //const char* defaultHex = 
  unsigned char RgbColor[3];
  char * hex = tinyfd_colorChooser(title, NULL, RgbColor, RgbColor);
  if (hex != NULL) {wren->setSlotString(vm, 0, hex);}
  else {wren->setSlotNull(vm, 0);}
}

DOME_EXPORT DOME_Result PLUGIN_onInit(DOME_getAPIFunction DOME_getAPI,
    DOME_Context ctx) {

  // Fetch the latest Core API and save it for later use.
  core = DOME_getAPI(API_DOME, DOME_API_VERSION);

  // DOME also provides a subset of the Wren API for accessing slots
  // in foreign methods.
  wren = DOME_getAPI(API_WREN, WREN_API_VERSION);

  core->log(ctx, "Initialising external module\n");

  // Register a module with it's associated source.
  // Avoid giving the module a common name.

  core->registerModule(ctx, "dialog", DIALOG_WREN_SOURCE);
  core->registerClass(ctx, "dialog", "Dialog", DIALOG_allocate, NULL);

  core->registerFn(ctx, "dialog", "static Dialog.messageBox(_,_,_,_)", DIALOG_messageBox);
  core->registerFn(ctx, "dialog", "static Dialog.inputBox(_,_,_)", DIALOG_inputBox);
  core->registerFn(ctx, "dialog", "static Dialog.saveFile(_,_,_,_)", DIALOG_saveFile);
  core->registerFn(ctx, "dialog", "static Dialog.openFile(_,_,_,_)", DIALOG_openFile);
  core->registerFn(ctx, "dialog", "static Dialog.selectFolder(_,_)", DIALOG_selectFolder);
  core->registerFn(ctx, "dialog", "static Dialog.colorPicker(_)", DIALOG_colorPicker);

  // Returning anything other than SUCCESS here will result in the current fiber
  // aborting. Use this to indicate if your plugin initialised successfully.
  return DOME_RESULT_SUCCESS;
}

DOME_EXPORT DOME_Result PLUGIN_preUpdate(DOME_Context ctx) {
  return DOME_RESULT_SUCCESS;
}

DOME_EXPORT DOME_Result PLUGIN_postUpdate(DOME_Context ctx) {
  return DOME_RESULT_SUCCESS;
}
DOME_EXPORT DOME_Result PLUGIN_preDraw(DOME_Context ctx) {
  return DOME_RESULT_SUCCESS;
}
DOME_EXPORT DOME_Result PLUGIN_postDraw(DOME_Context ctx) {
  return DOME_RESULT_SUCCESS;
}

DOME_EXPORT DOME_Result PLUGIN_onShutdown(DOME_Context ctx) {
  return DOME_RESULT_SUCCESS;
}