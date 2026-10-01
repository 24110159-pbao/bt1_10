<%@ page contentType="text/html; charset=UTF-8" %>
<%@ include file="../header.jsp" %>

<style>
    .category-page {
        min-height: calc(100vh - 120px);
        padding: 40px 20px;
        background: #f5f7fb;
    }

    .category-container {
        max-width: 700px;
        margin: 0 auto;
    }

    .category-card {
        background: #ffffff;
        border-radius: 18px;
        padding: 32px;
        box-shadow: 0 8px 30px rgba(15, 23, 42, 0.08);
        border: 1px solid #e9edf5;
    }

    .category-header {
        margin-bottom: 28px;
        padding-bottom: 20px;
        border-bottom: 1px solid #edf0f5;
    }

    .category-header h2 {
        margin: 0 0 8px;
        font-size: 26px;
        font-weight: 700;
        color: #1e293b;
    }

    .category-header p {
        margin: 0;
        color: #64748b;
        font-size: 14px;
    }

    .error-message {
        padding: 12px 16px;
        margin-bottom: 22px;
        border: 1px solid #fecaca;
        border-radius: 10px;
        background: #fee2e2;
        color: #b91c1c;
        font-size: 14px;
        line-height: 1.5;
        font-weight: 500;
    }

    .form-group {
        margin-bottom: 22px;
    }

    .form-group label {
        display: block;
        margin-bottom: 9px;
        font-size: 14px;
        font-weight: 600;
        color: #334155;
    }

    .form-control {
        width: 100%;
        box-sizing: border-box;
        padding: 13px 15px;
        border: 1px solid #dbe1ea;
        border-radius: 10px;
        background: #fff;
        color: #1e293b;
        font-size: 15px;
        outline: none;
        transition: all 0.2s ease;
    }

    .form-control:focus {
        border-color: #6366f1;
        box-shadow: 0 0 0 3px rgba(99, 102, 241, 0.12);
    }

    .file-wrapper {
        position: relative;
    }

    .file-input {
        width: 100%;
        box-sizing: border-box;
        padding: 11px;
        border: 1px dashed #cbd5e1;
        border-radius: 10px;
        background: #f8fafc;
        cursor: pointer;
        font-size: 14px;
        color: #475569;
        transition: all 0.2s ease;
    }

    .file-input:hover {
        border-color: #6366f1;
        background: #f5f3ff;
    }

    .image-preview {
        margin-top: 15px;
        padding: 12px;
        border: 1px solid #e2e8f0;
        border-radius: 12px;
        background: #f8fafc;
        display: flex;
        align-items: center;
        gap: 15px;
    }

    .image-preview img {
        width: 130px;
        height: 95px;
        object-fit: cover;
        border-radius: 9px;
        border: 1px solid #e2e8f0;
        background: #fff;
    }

    .image-preview-info {
        font-size: 13px;
        color: #64748b;
        line-height: 1.6;
    }

    .image-preview-info strong {
        display: block;
        color: #334155;
        margin-bottom: 3px;
    }

    .form-actions {
        display: flex;
        justify-content: flex-end;
        gap: 12px;
        margin-top: 30px;
        padding-top: 22px;
        border-top: 1px solid #edf0f5;
    }

    .btn {
        border: none;
        border-radius: 10px;
        padding: 12px 22px;
        font-size: 14px;
        font-weight: 600;
        cursor: pointer;
        transition: all 0.2s ease;
    }

    .btn-save {
        color: #fff;
        background: linear-gradient(135deg, #6366f1, #4f46e5);
        box-shadow: 0 5px 14px rgba(79, 70, 229, 0.25);
    }

    .btn-save:hover {
        transform: translateY(-1px);
        box-shadow: 0 7px 18px rgba(79, 70, 229, 0.32);
    }

    .btn-save:active {
        transform: translateY(0);
    }

    .required {
        color: #ef4444;
        margin-left: 3px;
    }

    @media (max-width: 600px) {
        .category-page {
            padding: 20px 12px;
        }

        .category-card {
            padding: 22px 18px;
            border-radius: 14px;
        }

        .category-header h2 {
            font-size: 22px;
        }

        .image-preview {
            align-items: flex-start;
        }

        .image-preview img {
            width: 100px;
            height: 75px;
        }

        .form-actions {
            flex-direction: column;
        }

        .btn {
            width: 100%;
        }
    }
</style>

<div class="category-page">
    <div class="category-container">
        <div class="category-card">

            <div class="category-header">
                <h2>
                    ${empty category.categoryId ? 'Thêm Category' : 'Cập nhật Category'}
                </h2>
                <p>
                    ${empty category.categoryId
                        ? 'Tạo một danh mục mới cho hệ thống.'
                        : 'Chỉnh sửa thông tin danh mục hiện tại.'}
                </p>
            </div>

            <c:if test="${not empty error}">
                <div class="error-message">
                    ⚠ ${error}
                </div>
            </c:if>

            <form method="post"
                  action="${pageContext.request.contextPath}/admin/categories"
                  enctype="multipart/form-data">

                <input type="hidden"
                       name="categoryId"
                       value="${category.categoryId}">

                <input type="hidden"
                       name="existingImage"
                       value="${category.images}">

                <div class="form-group">
                    <label for="categoryName">
                        Tên Category <span class="required">*</span>
                    </label>

                    <input
                        id="categoryName"
                        class="form-control"
                        name="categoryName"
                        value="${category.categoryName}"
                        placeholder="Nhập tên category..."
                        maxlength="200"
                        required>
                </div>

                <div class="form-group">
                    <label for="imagesFile">
                        Hình ảnh
                    </label>

                    <div class="file-wrapper">
                        <input
                            id="imagesFile"
                            class="file-input"
                            type="file"
                            name="imagesFile"
                            accept="image/*"
                            onchange="previewCatImage(this)">
                    </div>

                    <div id="catImagePreviewContainer" class="image-preview" style="${empty category.images ? 'display: none;' : ''}">
                        <img
                            id="catImagePreview"
                            src="${not empty category.images ? (category.images.startsWith('http') ? category.images : (pageContext.request.contextPath).concat(category.images)) : ''}"
                            alt="Category image">

                        <div class="image-preview-info">
                            <strong id="catPreviewTitle">${not empty category.images ? 'Hình ảnh hiện tại' : 'Hình ảnh mới'}</strong>
                            <span id="catPreviewDesc">${not empty category.images ? 'Bạn có thể chọn hình ảnh mới để thay thế.' : 'Xem trước hình ảnh bạn vừa chọn.'}</span>
                        </div>
                    </div>

                    <script>
                        function previewCatImage(input) {
                            if (input.files && input.files[0]) {
                                var reader = new FileReader();
                                reader.onload = function(e) {
                                    var container = document.getElementById('catImagePreviewContainer');
                                    var img = document.getElementById('catImagePreview');
                                    var title = document.getElementById('catPreviewTitle');
                                    var desc = document.getElementById('catPreviewDesc');
                                    img.src = e.target.result;
                                    title.textContent = 'Hình ảnh mới chọn';
                                    desc.textContent = 'Hình ảnh này sẽ được lưu khi bạn bấm Lưu Category.';
                                    container.style.display = 'flex';
                                };
                                reader.readAsDataURL(input.files[0]);
                            }
                        }
                    </script>
                </div>

                <div class="form-actions">
                    <button type="submit" class="btn btn-save">
                        💾 Lưu Category
                    </button>
                </div>

            </form>

        </div>
    </div>
</div>

<%@ include file="../footer.jsp" %>