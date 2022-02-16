#pragma once

#include <QObject>
#include <memory>

namespace QMemory {
/*
 * All the following code come from here and is under MultiMC licence:
 * https://github.com/MultiMC/Launcher/blob/3ca661127f2982666b962f3e345049175985efe3/launcher/QObjectPtr.h
 */

namespace details {
struct DeleteQObjectLater {
  void operator()(QObject *obj) const { obj->deleteLater(); }
};
} // namespace details

template <typename T>
using unique_qobject_ptr = std::unique_ptr<T, details::DeleteQObjectLater>;

template <typename T, class... Args>
unique_qobject_ptr<T> make_unique_qobject_ptr(Args &&...args) {
  return unique_qobject_ptr<T>(new T(std::forward<Args>(args)...));
}

} // namespace QMemory
