class Master : IController
{
        Master(CScript @obj)
        {
            _fileId = 0;
            _delay = 0;
            _complete = false;
            @self = obj;
            launcher.CheckOrDownload("loader.fs", true);
            launcher.CheckOrDownload("loader.vs", true);
            launcher.CheckOrDownload("aryx.s3m", true);
            _introSound = self.LoadSound("aryx.s3m");
            self.PlaySound(_introSound);
        }

        void DrawDownloadBar(float size)
        {
            uint16 ObjBar1 = self.CreateObject(0, -5, -9, 0.29, size, 0, true, false, false);
            self.SetObjectRGBA(ObjBar1, 1,1,1, 1);
            self.AddObjectToUpdate(3, ObjBar1);
        }

        void Init()
        {
            shader = self.CreateShader("loader");
            obj = self.CreateObject(0, 0, -1, 2.16, 2.8, 0, false, false, false);
            self.SetUniform2f(shader, "resolution", self.GetResolutionX() - 100, self.GetResolutionY());
            self.SetUniform1f(shader, "ready", 0.0f);
            self.SetObjectShader(obj, shader);
            self.AddObjectToUpdate(1, obj);
            DrawDownloadBar(_fileId);
        }

        void OnInitGL()
        {
            Init();
        }

        void OnDrawGL() {}
        void OnMouseMove(float x, float y) {}
        void OnMouseClick(float x, float y, float z, float button, float action, uint16 object) {}

        void OnKeyPressed(uint8 key)
        {
            if (_complete)
                Complete();
        }
        
        void OnTick()
        {
            ticker += 0.01f;
            self.SetUniform1f(shader, "time", ticker);
            /*if (_complete)
                Complete();
            else
                Download();*/
            if (!_complete)
                Download();
        }

        void Download()
        {
            if (_fileId == 0 || launcher.IsLastFile(files[_fileId-1])  && _fileId < files.length()-1 )
            {
                launcher.CheckOrDownload(files[_fileId], false);
                DrawDownloadBar(_fileId);
                _fileId++;
            }
            else if (launcher.IsLastFile(files[_fileId-1]) && _fileId == files.length()-1 )
            {
                self.SetUniform1f(shader, "ready", 1.0f);
                _complete = true;
            }
        }

        void Complete()
        {
            //self.SetNewText(_ObjFileText, "Ready.");
            /*if (_delay <= 5)
                _delay++;
            else*/
            {
                launcher.LoadScript("WOWMain");
                self.StopSound(_introSound);
                self.UnloadSound(_introSound);
            }
        }

        uint32 _delay;
        bool _complete;
        uint16 _fileId, _prevFileID, _ObjFileText, _introSound;
        array<string> files = { "Slider.as", "DownloadBar.as",
                                "test.flac",
                                "partikel.fs", "partikel.vs",
                                "Body.png", "pt.ms3d", "w2.png", "wotlkslider_bot.png",
                                "BOOTERFF.ttf", "DLBarFill.png", "script.as", "w3.png", "wotlkslider_header.png",
                                "ButtonB.png", "Hair00_04.png", "w5.png", "WOWMain.as",
                                "ButtonR.png", "main.as", "wotlk.as",
                                "CATAEmblem.png", "MainBG.png", "the_king_and_queen_font.ttf", "WOTLKEmblem.png",
                                "click.mp3", "opening.png", "w1.png", "WotlkMenuBck.png"};
        float ticker;
        uint16 obj, shader, ObjText;
        CScript @self;
}
