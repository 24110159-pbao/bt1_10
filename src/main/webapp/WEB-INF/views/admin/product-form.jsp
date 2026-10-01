<%@ page contentType="text/html; charset=UTF-8" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<%@ include file="../header.jsp" %>

<style>
    .product-page {
        min-height: calc(100vh - 120px);
        padding: 40px 20px;
        background: #f5f7fb;
    }

    .product-container {
        max-width: 850px;
        margin: 0 auto;
    }

    .product-card {
        background: #ffffff;
        border-radius: 18px;
        padding: 32px;
        box-shadow: 0 8px 30px rgba(15, 23, 42, 0.08);
        border: 1px solid #e9edf5;
    }

    /* Header */
    .product-header {
        margin-bottom: 28px;
        padding-bottom: 20px;
        border-bottom: 1px solid #edf0f5;
    }

    .product-header h2 {
        margin: 0 0 8px;
        font-size: 26px;
        font-weight: 700;
        color: #1e293b;
    }

    .product-header p {
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

    /* Section */
    .form-section {
        margin-bottom: 28px;
        padding-bottom: 25px;
        border-bottom: 1px solid #edf0f5;
    }

    .form-section:last-of-type {
        border-bottom: none;
        margin-bottom: 0;
    }

    .section-title {
        display: flex;
        align-items: center;
        gap: 9px;
        margin-bottom: 18px;
        color: #334155;
        font-size: 16px;
        font-weight: 700;
    }

    .section-icon {
        display: inline-flex;
        align-items: center;
        justify-content: center;
        width: 32px;
        height: 32px;
        border-radius: 8px;
        background: #eef2ff;
        color: #4f46e5;
        font-size: 15px;
    }

    /* Grid */
    .form-grid {
        display: grid;
        grid-template-columns: repeat(2, minmax(0, 1fr));
        gap: 20px;
    }

    .form-grid.three-columns {
        grid-template-columns: repeat(3, minmax(0, 1fr));
    }

    .form-group {
        margin-bottom: 0;
    }

    .form-group.full-width {
        grid-column: 1 / -1;
    }

    .form-group label {
        display: block;
        margin-bottom: 8px;
        color: #334155;
        font-size: 14px;
        font-weight: 600;
    }

    .required {
        color: #ef4444;
        margin-left: 3px;
    }

    /* Inputs */
    .form-control,
    .form-select,
    .form-textarea {
        width: 100%;
        box-sizing: border-box;
        padding: 12px 14px;
        border: 1px solid #dbe1ea;
        border-radius: 10px;
        background: #ffffff;
        color: #1e293b;
        font-family: inherit;
        font-size: 14px;
        outline: none;
        transition: all 0.2s ease;
    }

    .form-control::placeholder,
    .form-textarea::placeholder {
        color: #94a3b8;
    }

    .form-control:focus,
    .form-select:focus,
    .form-textarea:focus {
        border-color: #6366f1;
        box-shadow: 0 0 0 3px rgba(99, 102, 241, 0.12);
    }

    .form-select {
        cursor: pointer;
        appearance: auto;
    }

    .form-textarea {
        min-height: 130px;
        resize: vertical;
        line-height: 1.6;
    }

    /* Number input */
    .number-input {
        position: relative;
    }

    .number-input .form-control {
        padding-right: 55px;
    }

    .input-unit {
        position: absolute;
        right: 13px;
        top: 50%;
        transform: translateY(-50%);
        color: #94a3b8;
        font-size: 12px;
        pointer-events: none;
    }

    /* File */
    .file-input {
        width: 100%;
        box-sizing: border-box;
        padding: 11px;
        border: 1px dashed #cbd5e1;
        border-radius: 10px;
        background: #f8fafc;
        cursor: pointer;
        color: #475569;
        font-family: inherit;
        font-size: 14px;
        transition: all 0.2s ease;
    }

    .file-input:hover {
        border-color: #6366f1;
        background: #f5f3ff;
    }

    .image-preview {
        display: flex;
        align-items: center;
        gap: 16px;
        margin-top: 15px;
        padding: 12px;
        border: 1px solid #e2e8f0;
        border-radius: 12px;
        background: #f8fafc;
    }

    .image-preview img {
        width: 140px;
        height: 100px;
        object-fit: cover;
        border-radius: 9px;
        border: 1px solid #e2e8f0;
        background: #fff;
    }

    .image-preview-info {
        color: #64748b;
        font-size: 13px;
        line-height: 1.6;
    }

    .image-preview-info strong {
        display: block;
        margin-bottom: 3px;
        color: #334155;
    }

    /* Actions */
    .form-actions {
        display: flex;
        justify-content: flex-end;
        gap: 12px;
        margin-top: 28px;
        padding-top: 22px;
        border-top: 1px solid #edf0f5;
    }

    .btn {
        border: none;
        border-radius: 10px;
        padding: 12px 23px;
        font-family: inherit;
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

    /* Responsive */
    @media (max-width: 700px) {
        .product-page {
            padding: 20px 12px;
        }

        .product-card {
            padding: 22px 18px;
            border-radius: 14px;
        }

        .product-header h2 {
            font-size: 22px;
        }

        .form-grid,
        .form-grid.three-columns {
            grid-template-columns: 1fr;
        }

        .form-group.full-width {
            grid-column: auto;
        }

        .image-preview {
            align-items: flex-start;
        }

        .image-preview img {
            width: 105px;
            height: 78px;
        }

        .form-actions {
            flex-direction: column;
        }

        .btn {
            width: 100%;
        }
    }
</style>

<div class="product-page">
    <div class="product-container">

        <div class="product-card">

            <!-- Header -->
            <div class="product-header">
                <h2>
                    ${empty product.productId
                        ? 'Thêm Product'
                        : 'Cập nhật Product'}
                </h2>

                <p>
                    ${empty product.productId
                        ? 'Nhập thông tin để tạo sản phẩm mới.'
                        : 'Chỉnh sửa thông tin sản phẩm hiện tại.'}
                </p>
            </div>

            <c:if test="${not empty error}">
                <div class="error-message">
                    ⚠ ${error}
                </div>
            </c:if>

            <form method="post"
                  action="${pageContext.request.contextPath}/admin/products"
                  enctype="multipart/form-data">

                <input type="hidden"
                       name="productId"
                       value="${product.productId}">

                <input type="hidden"
                       name="existingImage"
                       value="${product.images}">


                <!-- Thông tin sản phẩm -->
                <div class="form-section">

                    <div class="section-title">
                        <span class="section-icon">📦</span>
                        Thông tin sản phẩm
                    </div>

                    <div class="form-grid">

                        <div class="form-group">
                            <label for="productName">
                                Tên sản phẩm
                                <span class="required">*</span>
                            </label>

                            <input
                                id="productName"
                                class="form-control"
                                name="productName"
                                value="${product.productName}"
                                placeholder="Nhập tên sản phẩm..."
                                maxlength="200"
                                required>
                        </div>

                        <div class="form-group">
                            <label for="productCode">
                                Mã sản phẩm
                                <span class="required">*</span>
                            </label>

                            <input
                                id="productCode"
                                class="form-control"
                                type="number"
                                min="1"
                                name="productCode"
                                value="${product.productCode}"
                                placeholder="VD: 001"
                                required>
                        </div>

                    </div>
                </div>


                <!-- Phân loại -->
                <div class="form-section">

                    <div class="section-title">
                        <span class="section-icon">🏷️</span>
                        Phân loại
                    </div>

                    <div class="form-grid">

                        <div class="form-group">
                            <label for="categoryId">
                                Danh mục
                                <span class="required">*</span>
                            </label>

                            <select
                                id="categoryId"
                                class="form-select"
                                name="categoryId"
                                required>

                                <option value="">
                                    -- Chọn danh mục --
                                </option>

                                <c:forEach var="c" items="${categories}">
                                    <option
                                        value="${c.categoryId}"
                                        ${product.category.categoryId == c.categoryId ? 'selected' : ''}>
                                        ${c.categoryName}
                                    </option>
                                </c:forEach>

                            </select>
                        </div>


                        <div class="form-group">
                            <label for="sellerId">
                                Seller
                                <span class="required">*</span>
                            </label>

                            <select
                                id="sellerId"
                                class="form-select"
                                name="sellerId"
                                required>

                                <option value="">
                                    -- Chọn Seller --
                                </option>

                                <c:forEach var="s" items="${sellers}">
                                    <option
                                        value="${s.sellerId}"
                                        ${product.seller.sellerId == s.sellerId ? 'selected' : ''}>
                                        ${s.sellername}
                                    </option>
                                </c:forEach>

                            </select>
                        </div>

                    </div>
                </div>


                <!-- Giá và kho -->
                <div class="form-section">

                    <div class="section-title">
                        <span class="section-icon">💰</span>
                        Giá & Kho hàng
                    </div>

                    <div class="form-grid">

                        <div class="form-group">
                            <label for="price">
                                Giá
                                <span class="required">*</span>
                            </label>

                            <div class="number-input">
                                <input
                                    id="price"
                                    class="form-control"
                                    type="number"
                                    step="0.01"
                                    min="0"
                                    name="price"
                                    value="${product.price}"
                                    placeholder="0.00"
                                    required>

                                <span class="input-unit">VNĐ</span>
                            </div>
                        </div>


                        <div class="form-group">
                            <label for="stock">
                                Số lượng tồn kho
                                <span class="required">*</span>
                            </label>

                            <div class="number-input">
                                <input
                                    id="stock"
                                    class="form-control"
                                    type="number"
                                    min="0"
                                    name="stock"
                                    value="${product.stock != null ? product.stock : product.amount}"
                                    placeholder="0"
                                    required>

                                <span class="input-unit">sản phẩm</span>
                            </div>
                        </div>

                    </div>
                </div>


                <!-- Mô tả -->
                <div class="form-section">

                    <div class="section-title">
                        <span class="section-icon">📝</span>
                        Mô tả sản phẩm
                    </div>

                    <div class="form-group">
                        <label for="description">
                            Description
                        </label>

                        <textarea
                            id="description"
                            class="form-textarea"
                            name="description"
                            maxlength="500"
                            placeholder="Nhập mô tả sản phẩm (tối đa 500 ký tự)...">${product.description}</textarea>
                    </div>

                </div>


                <!-- Hình ảnh -->
                <div class="form-section">

                    <div class="section-title">
                        <span class="section-icon">🖼️</span>
                        Hình ảnh sản phẩm
                    </div>

                    <div class="form-group">

                        <label for="imagesFile">
                            Chọn hình ảnh
                        </label>

                        <input
                            id="imagesFile"
                            class="file-input"
                            type="file"
                            name="imagesFile"
                            accept="image/*"
                            onchange="previewProductImage(this)">

                        <div id="imagePreviewContainer" class="image-preview" style="${empty product.images ? 'display: none;' : ''}">
                            <img
                                id="productImagePreview"
                                src="${not empty product.images ? (product.images.startsWith('http') ? product.images : (pageContext.request.contextPath).concat(product.images)) : ''}"
                                alt="Product image">

                            <div class="image-preview-info">
                                <strong id="previewTitle">${not empty product.images ? 'Hình ảnh hiện tại' : 'Hình ảnh mới'}</strong>
                                <span id="previewDesc">${not empty product.images ? 'Chọn hình ảnh mới nếu bạn muốn thay thế ảnh hiện tại.' : 'Xem trước hình ảnh bạn vừa chọn.'}</span>
                            </div>
                        </div>

                        <script>
                            function previewProductImage(input) {
                                if (input.files && input.files[0]) {
                                    var reader = new FileReader();
                                    reader.onload = function(e) {
                                        var container = document.getElementById('imagePreviewContainer');
                                        var img = document.getElementById('productImagePreview');
                                        var title = document.getElementById('previewTitle');
                                        var desc = document.getElementById('previewDesc');
                                        img.src = e.target.result;
                                        title.textContent = 'Hình ảnh mới chọn';
                                        desc.textContent = 'Hình ảnh này sẽ được lưu khi bạn bấm Lưu Product.';
                                        container.style.display = 'flex';
                                    };
                                    reader.readAsDataURL(input.files[0]);
                                }
                            }
                        </script>

                    </div>
                </div>


                <!-- Actions -->
                <div class="form-actions">

                    <button type="submit" class="btn btn-save">
                        💾 Lưu Product
                    </button>

                </div>

            </form>

        </div>
    </div>
</div>

<%@ include file="../footer.jsp" %>
