{-# LANGUAGE OverloadedStrings #-}
module Ideas.Rest.HTML.Page (makePage) where

import Control.Monad
import Lucid
import Data.Text

makePage :: Monad m => HtmlT m () -> HtmlT m ()
makePage content = do
   doctype_
   html_ $ do
      title_ "Hello world"
      meta_ [name_ "viewport", content_ "width=device-width, initial-scale=1"]
      stylesheet "http://www.w3schools.com/lib/w3.css"
      stylesheet "http://www.w3schools.com/lib/w3-theme-black.css"
      stylesheet "https://fonts.googleapis.com/css?family=Roboto"
      stylesheet "https://cdnjs.cloudflare.com/ajax/libs/font-awesome/4.6.3/css/font-awesome.min.css"
      style_ styleTxt
      body_ $ do
         navBar
         sidenav
         overlayEffect
         div_ [class_ "w3-main", style_ "margin-left:250px"] $ do
            div_ [class_ "w3-row w3-padding-64"] content
            footer
         script_ scriptTxt
   
styleTxt :: Text
styleTxt =
   "html,body,h1,h2,h3,h4,h5,h6 {font-family: \"Roboto\", sans-serif}\n\
   \.w3-sidenav a,.w3-sidenav h4 {padding: 12px;}\n\
   \.w3-navbar li a {\n\
   \    padding-top: 12px;\n\
   \    padding-bottom: 12px;\n\
   \}"
   
navBar :: Monad m => HtmlT m ()
navBar = div_ [class_ "w3-top"] $ do
   ul_ [class_ "w3-navbar w3-theme w3-top w3-left-align w3-large"] $ do
      li_ [class_ "w3-opennav w3-right w3-hide-large"] $
         a_ [class_ "w3-hover-white w3-large w3-theme-l1", href_ "javascript:void(0)", onclick_ "w3_open()"] $
            i_ [class_ "fa fa-bars"] $ mempty
      li_ $ a_ [href_ "#", class_ "w3-theme-l1"] "Logo"
      li_ [class_ "w3-hide-small"] $
         a_ [href_ "#", class_ "w3-hover-white"] $
            "Contact"
      li_ [class_ "w3-hide-medium w3-hide-small"] $
         a_ [href_ "#", class_ "w3-hover-white"] $
            "Partners"

sidenav :: Monad m => HtmlT m ()
sidenav = nav_ [class_ "w3-sidenav w3-collapse w3-theme-l5", style_ "z-index:3;width:250px;margin-top:51px;", id_ "mySidenav"] $ do
   a_ [href_ "javascript:void(0)", onclick_ "w3_close()", class_ "w3-right w3-xlarge w3-padding-large w3-hover-black w3-hide-large", title_ "close menu"] $
      i_ [class_ "fa fa-remove"] mempty
   h4_ $ b_ "Menu"
   replicateM_ 4 $ 
      a_ [href_ "#", class_ "w3-hover-black"] "Link"

footer :: Monad m => HtmlT m ()
footer = footer_ [id_ "myFooter"] $ do
   div_ [class_ "w3-container w3-theme-l2 w3-padding-32"] $
      h4_ "Footer"
   div_ [class_ "w3-container w3-theme-l1"] $
      p_ $ do
         "Powered by "
         a_ [href_ "http://www.w3schools.com/w3css/default.asp", target_ "_blank"] $
            "w3.css"

overlayEffect :: Monad m => HtmlT m ()
overlayEffect = 
   div_ [class_ "w3-overlay w3-hide-large", onclick_ "w3_close()", style_ "cursor:pointer", title_ "close side menu", id_ "myOverlay"] mempty

scriptTxt :: Text
scriptTxt =
   "// Get the Sidenav\n\
   \var mySidenav = document.getElementById(\"mySidenav\");\n\
   \// Get the DIV with overlay effect\n\
   \var overlayBg = document.getElementById(\"myOverlay\");\n\
   \// Toggle between showing and hiding the sidenav, and add overlay effect\n\
   \function w3_open() {\n\
   \    if (mySidenav.style.display === 'block') {\n\
   \        mySidenav.style.display = 'none';\n\
   \        overlayBg.style.display = \"none\";\n\
   \    } else {\n\
   \        mySidenav.style.display = 'block';\n\
   \        overlayBg.style.display = \"block\";\n\
   \    }\n\
   \}\n\
   \// Close the sidenav with the close button\n\
   \function w3_close() {\n\
   \    mySidenav.style.display = \"none\";\n\
   \    overlayBg.style.display = \"none\";\n\
   \}"
   
stylesheet :: Monad m => Text -> HtmlT m ()
stylesheet url = link_ [rel_ "stylesheet", href_ url]