class Master : IController
{
        Master(CScript @obj)
        {
            @self = obj;
        }

        void OnInitGL()
        {}

        void OnDrawGL()
        {}

        void OnMouseMove(float x, float y)
        {}

        void OnMouseClick(float x, float y, float z, float button, float action, uint16 object)
        {}

        void OnTick()
        {}

        void onKeyPressed(uint8 key)
        {}

        CScript @self;
}
