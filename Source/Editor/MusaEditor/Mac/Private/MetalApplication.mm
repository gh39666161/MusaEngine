#import "MusaEditor/Mac/Public/MetalApplication.h"

namespace MusaEngine
{
    CMetalApplication::CMetalApplication():CApplication()
    {
        
    }

    int32 CMetalApplication::Initialize()
    {
        return 0;
    }

    void CMetalApplication::Finalize()
    {
        CApplication::Finalize();
    }

    void CMetalApplication::Update()
    {
    }
}
