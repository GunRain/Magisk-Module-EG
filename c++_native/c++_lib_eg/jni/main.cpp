#include <iostream>

#include "zygisk.hpp"

using zygisk::Api;
using zygisk::AppSpecializeArgs;
using zygisk::ServerSpecializeArgs;

class Lib_EG : public zygisk::ModuleBase {
public:
    void onLoad(Api* api, JNIEnv* env) override {
        this->api = api;
        this->env = env;
    }

private:
    Api*    api;
    JNIEnv* env;
};

REGISTER_ZYGISK_MODULE(Lib_EG)