
#include <string>
#include <vector>

#include "lda.h"
#include "infer.h"
#include "stdio.h"

#include "LDAModel.h"

#include <node.h>

using namespace v8;


namespace lda
{
    LDAModel::LDAModel() {
        _corpus = std::vector<std::string>();
        _inference = std::vector<std::string>();
    }
    
    LDAModel::~LDAModel() {
    }
    
    Persistent<Function> LDAModel::constructor;
    
    void LDAModel::Init(Handle<Object> exports) {
        // Prepare constructor template
        Local<FunctionTemplate> tpl = FunctionTemplate::New(New);
        tpl->SetClassName(String::NewSymbol("LDAModel"));
        tpl->InstanceTemplate()->SetInternalFieldCount(1);

        constructor = Persistent<Function>::New(tpl->GetFunction());
        exports->Set(String::NewSymbol("LDAModel"), constructor);
    }
    
    Handle<Value> LDAModel::New(const Arguments& args) {
        HandleScope scope;
        
        if (args.IsConstructCall()) {
            LDAModel *obj = new LDAModel();
            obj->Wrap(args.This());
            return args.This();
        } else {
            return scope.Close(constructor->NewInstance());
        }
    }

    Handle<Value> LDAModel::NewInstance(const Arguments& args) {
        HandleScope scope;
        Local<Object> instance = constructor->NewInstance();
        return scope.Close(instance);
    }

}