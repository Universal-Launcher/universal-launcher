#include "secrets.h"

#include <array>
#include <cstdio>

namespace {
QString MSAClientID = "";
}

namespace Secrets {

bool hasMSAClientID() { return !MSAClientID.isEmpty(); }

QString getMSAClientID() { return MSAClientID; }
} // namespace Secrets
