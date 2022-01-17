set(CMAKE_INCLUDE_CURRENT_DIR ON)

set(CMAKE_CXX_STANDARD 20)
set(CMAKE_CXX_STANDARD_REQUIRED ON)

find_package(Qt6 6.2 COMPONENTS Core Quick LinguistTools NetworkAuth REQUIRED)

set(TS_FILES universal-launcher_en_GB.ts)

set(SRC
    main.cpp
    auth/authentication.h auth/authentication.cpp
    auth/accountdata.h auth/accountdata.cpp
    )

set(PROJECT_SOURCES
        ${SRC}
        ${TS_FILES})

qt_add_resources(PROJECT_SOURCES ../resources.qrc)

qt_add_executable(universal-launcher
    ${PROJECT_SOURCES}
)

qt_create_translation(QM_FILES ${CMAKE_SOURCE_DIR} ${TS_FILES})

target_compile_definitions(universal-launcher
    PRIVATE $<$<OR:$<CONFIG:Debug>,$<CONFIG:RelWithDebInfo>>:QT_QML_DEBUG>)
target_link_libraries(universal-launcher
    PRIVATE Qt6::Core Qt6::Quick Qt6::NetworkAuth)
