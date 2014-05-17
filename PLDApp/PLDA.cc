#include <node.h>
#include <node_buffer.h>

#include "LDAModel.h"

using namespace lda;
using namespace v8;


void InitAll(Handle<Object> exports) {
    lda::LDAModel::Init(exports);
}

NODE_MODULE(plda, InitAll);