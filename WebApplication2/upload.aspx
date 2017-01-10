<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="upload.aspx.cs" Inherits="WebApplication2.upload" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
    <title></title>
    <script src="script/jquery-1.10.2.min.js"></script>
    <script src="script/upload.js"></script>

</head>
<body>
    <form id="form1" runat="server">
        <div>
            <asp:FileUpload ID="FileUpload1" runat="server" />
            <asp:Button ID="Button1" runat="server" Text="提交" OnClick="Button1_Click" />
            <br />
            <input id="btnupload" type="button" onclick="uploadstart('FileUpload1')" value="button" />
        </div>
    </form>
    <script>
        function uploadstart(eleid) {
            var formData = new FormData(),
                  oFile = $('#' + eleid)[0].files[0],
                  imgSize = oFile.size;

            if (imgSize < 256 * 1024) {
                formData.append(eleid, oFile);
                uploadPic(formData);
            } else {    // 图片压缩处理
                var reader = new FileReader(),
                    maxWidth = 400,
                    maxHeight = 400,
                    suffix = oFile.name.substring(oFile.name.lastIndexOf('.') + 1);

                if (imgSize > 2 * 1024 * 1024) {
                    maxWidth = 800;
                    maxHeight = 800;
                }

                reader.onload = function (e) {
                    var base64Img = e.target.result;
                    //--执行resize。
                    var _ir = ImageResizer({
                        resizeMode: "auto",
                        dataSource: base64Img,
                        dataSourceType: "base64",
                        maxWidth: maxWidth, //允许的最大宽度
                        maxHeight: maxHeight, //允许的最大高度。
                        onTmpImgGenerate: function (img) {
                        },
                        success: function (resizeImgBase64, canvas) {
                            var blob = dataURLtoBlob(resizeImgBase64);
                            formData.append(eleid, blob, oFile['name']);

                            uploadPic(formData);
                        }
                    });
                };
                reader.readAsDataURL(oFile);
            }
        }
        function uploadPic(formData) {
            var oReq = new XMLHttpRequest();
            oReq.open("POST", "upload.ashx", true);
            oReq.onload = function (oEvent) {
                if (oReq.status == 200) {
                    alert(oReq.response);
                } else {
                    //oOutput.innerHTML = "Error " + oReq.status + " occurred uploading your file.<br \/>";
                    alert(oReq.status);
                }
            };

            oReq.send(formData);
        }

    </script>
</body>
</html>
