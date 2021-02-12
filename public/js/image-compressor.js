// /*!
//  * Image Compressor v1.1.4
//  * https://xkeshi.github.io/image-compressor
//  *
//  * Copyright 2017-present Chen Fengyuan
//  * Released under the MIT license
//  *
//  * Date: 2018-06-20T07:28:41.051Z
//  */

// (function (global, factory) {
// 	typeof exports === 'object' && typeof module !== 'undefined' ? module.exports = factory() :
// 	typeof define === 'function' && define.amd ? define(factory) :
// 	(global.ImageCompressor = factory());
// }(this, (function () { 'use strict';

// 	function createCommonjsModule(fn, module) {
// 		return module = { exports: {} }, fn(module, module.exports), module.exports;
// 	}

// 	var canvasToBlob = createCommonjsModule(function (module) {
// 	(function (window) {

// 	  var CanvasPrototype =
// 	    window.HTMLCanvasElement && window.HTMLCanvasElement.prototype;
// 	  var hasBlobConstructor =
// 	    window.Blob &&
// 	    (function () {
// 	      try {
// 	        return Boolean(new Blob())
// 	      } catch (e) {
// 	        return false
// 	      }
// 	    })();
// 	  var hasArrayBufferViewSupport =
// 	    hasBlobConstructor &&
// 	    window.Uint8Array &&
// 	    (function () {
// 	      try {
// 	        return new Blob([new Uint8Array(100)]).size === 100
// 	      } catch (e) {
// 	        return false
// 	      }
// 	    })();
// 	  var BlobBuilder =
// 	    window.BlobBuilder ||
// 	    window.WebKitBlobBuilder ||
// 	    window.MozBlobBuilder ||
// 	    window.MSBlobBuilder;
// 	  var dataURIPattern = /^data:((.*?)(;charset=.*?)?)(;base64)?,/;
// 	  var dataURLtoBlob =
// 	    (hasBlobConstructor || BlobBuilder) &&
// 	    window.atob &&
// 	    window.ArrayBuffer &&
// 	    window.Uint8Array &&
// 	    function (dataURI) {
// 	      var matches,
// 	        mediaType,
// 	        isBase64,
// 	        dataString,
// 	        byteString,
// 	        arrayBuffer,
// 	        intArray,
// 	        i,
// 	        bb;
// 	      // Parse the dataURI components as per RFC 2397
// 	      matches = dataURI.match(dataURIPattern);
// 	      if (!matches) {
// 	        throw new Error('invalid data URI')
// 	      }
// 	      // Default to text/plain;charset=US-ASCII
// 	      mediaType = matches[2]
// 	        ? matches[1]
// 	        : 'text/plain' + (matches[3] || ';charset=US-ASCII');
// 	      isBase64 = !!matches[4];
// 	      dataString = dataURI.slice(matches[0].length);
// 	      if (isBase64) {
// 	        // Convert base64 to raw binary data held in a string:
// 	        byteString = atob(dataString);
// 	      } else {
// 	        // Convert base64/URLEncoded data component to raw binary:
// 	        byteString = decodeURIComponent(dataString);
// 	      }
// 	      // Write the bytes of the string to an ArrayBuffer:
// 	      arrayBuffer = new ArrayBuffer(byteString.length);
// 	      intArray = new Uint8Array(arrayBuffer);
// 	      for (i = 0; i < byteString.length; i += 1) {
// 	        intArray[i] = byteString.charCodeAt(i);
// 	      }
// 	      // Write the ArrayBuffer (or ArrayBufferView) to a blob:
// 	      if (hasBlobConstructor) {
// 	        return new Blob([hasArrayBufferViewSupport ? intArray : arrayBuffer], {
// 	          type: mediaType
// 	        })
// 	      }
// 	      bb = new BlobBuilder();
// 	      bb.append(arrayBuffer);
// 	      return bb.getBlob(mediaType)
// 	    };
// 	  if (window.HTMLCanvasElement && !CanvasPrototype.toBlob) {
// 	    if (CanvasPrototype.mozGetAsFile) {
// 	      CanvasPrototype.toBlob = function (callback, type, quality) {
// 	        var self = this;
// 	        setTimeout(function () {
// 	          if (quality && CanvasPrototype.toDataURL && dataURLtoBlob) {
// 	            callback(dataURLtoBlob(self.toDataURL(type, quality)));
// 	          } else {
// 	            callback(self.mozGetAsFile('blob', type));
// 	          }
// 	        });
// 	      };
// 	    } else if (CanvasPrototype.toDataURL && dataURLtoBlob) {
// 	      CanvasPrototype.toBlob = function (callback, type, quality) {
// 	        var self = this;
// 	        setTimeout(function () {
// 	          callback(dataURLtoBlob(self.toDataURL(type, quality)));
// 	        });
// 	      };
// 	    }
// 	  }
// 	  if (typeof undefined === 'function' && undefined.amd) {
// 	    undefined(function () {
// 	      return dataURLtoBlob
// 	    });
// 	  } else if (module.exports) {
// 	    module.exports = dataURLtoBlob;
// 	  } else {
// 	    window.dataURLtoBlob = dataURLtoBlob;
// 	  }
// 	})(window);
// 	});

// 	/* globals Blob */
// 	var toString = Object.prototype.toString;

// 	var isBlob = function (x) {
// 		return x instanceof Blob || toString.call(x) === '[object Blob]';
// 	};

// 	var DEFAULTS = {
// 	  /**
// 	   * Indicates if read the image's Exif Orientation information,
// 	   * and then rotate or flip the image automatically.
// 	   * @type {boolean}
// 	   */
// 	  checkOrientation: true,

// 	  /**
// 	   * The max width of the output image.
// 	   * @type {number}
// 	   */
// 	  maxWidth: Infinity,

// 	  /**
// 	   * The max height of the output image.
// 	   * @type {number}
// 	   */
// 	  maxHeight: Infinity,

// 	  /**
// 	   * The min width of the output image.
// 	   * @type {number}
// 	   */
// 	  minWidth: 0,

// 	  /**
// 	   * The min height of the output image.
// 	   * @type {number}
// 	   */
// 	  minHeight: 0,

// 	  /**
// 	   * The width of the output image.
// 	   * If not specified, the natural width of the source image will be used.
// 	   * @type {number}
// 	   */
// 	  width: undefined,

// 	  /**
// 	   * The height of the output image.
// 	   * If not specified, the natural height of the source image will be used.
// 	   * @type {number}
// 	   */
// 	  height: undefined,

// 	  /**
// 	   * The quality of the output image.
// 	   * It must be a number between `0` and `1`,
// 	   * and only available for `image/jpeg` and `image/webp` images.
// 	   * Check out {@link https://developer.mozilla.org/en-US/docs/Web/API/HTMLCanvasElement/toBlob canvas.toBlob}.
// 	   * @type {number}
// 	   */
// 	  quality: 0.8,

// 	  /**
// 	   * The mime type of the output image.
// 	   * By default, the original mime type of the source image file will be used.
// 	   * @type {string}
// 	   */
// 	  mimeType: 'auto',

// 	  /**
// 	   * PNG files over this value (5M by default) will be converted to JPEGs.
// 	   * To disable this, just set the value to `Infinity`.
// 	   * Check out {@link https://github.com/xkeshi/image-compressor/issues/2 #2}.
// 	   * @type {number}
// 	   */
// 	  convertSize: 5000000,

// 	  /**
// 	   * The hook function to execute before draw the image into the canvas for compression.
// 	   * @type {Function}
// 	   * @param {CanvasRenderingContext2D} context - The 2d rendering context of the canvas.
// 	   * @param {HTMLCanvasElement} canvas - The canvas for compression.
// 	   * @example
// 	   * function (context, canvas) { context.fillStyle = '#fff' }
// 	   */
// 	  beforeDraw: null,

// 	  /**
// 	   * The hook function to execute after drew the image into the canvas for compression.
// 	   * @type {Function}
// 	   * @param {CanvasRenderingContext2D} context - The 2d rendering context of the canvas.
// 	   * @param {HTMLCanvasElement} canvas - The canvas for compression.
// 	   * @example
// 	   * function (context, canvas) { context.filter = grayscale(100%) }
// 	   */
// 	  drew: null,

// 	  /**
// 	   * The hook function to execute when success to compress the image.
// 	   * @type {Function}
// 	   * @param {File} file - The compressed image File object.
// 	   * @example
// 	   * function (file) { console.log(file) }
// 	   */
// 	  success: null,

// 	  /**
// 	   * The hook function to execute when fail to compress the image.
// 	   * @type {Function}
// 	   * @param {Error} err - An Error object.
// 	   * @example
// 	   * function (err) { console.log(err.message) }
// 	   */
// 	  error: null
// 	};

// 	var REGEXP_IMAGE_TYPE = /^image\/.+$/;

// 	/**
// 	 * Check if the given value is a mime type of image.
// 	 * @param {*} value - The value to check.
// 	 * @returns {boolean} Returns `true` if the given is a mime type of image, else `false`.
// 	 */
// 	function isImageType(value) {
// 	  return REGEXP_IMAGE_TYPE.test(value);
// 	}

// 	/**
// 	 * Convert image type to extension.
// 	 * @param {string} value - The image type to convert.
// 	 * @param {boolean} [includeDot=true] - Include a leading dot or not.
// 	 * @returns {boolean} Returns the image extension.
// 	 */
// 	function imageTypeToExtension(value) {
// 	  var includeDot = arguments.length > 1 && arguments[1] !== undefined ? arguments[1] : true;

// 	  var extension = isImageType(value) ? value.substr(6) : '';

// 	  if (extension === 'jpeg') {
// 	    extension = 'jpg';
// 	  }

// 	  if (extension && includeDot) {
// 	    extension = '.' + extension;
// 	  }

// 	  return extension;
// 	}

// 	var fromCharCode = String.fromCharCode;

// 	/**
// 	 * Get string from char code in data view.
// 	 * @param {DataView} dataView - The data view for read.
// 	 * @param {number} start - The start index.
// 	 * @param {number} length - The read length.
// 	 * @returns {string} The read result.
// 	 */

// 	function getStringFromCharCode(dataView, start, length) {
// 	  var str = '';
// 	  var i = void 0;

// 	  length += start;

// 	  for (i = start; i < length; i += 1) {
// 	    str += fromCharCode(dataView.getUint8(i));
// 	  }

// 	  return str;
// 	}

// 	var _window = window,
// 	    btoa = _window.btoa;

// 	/**
// 	 * Transform array buffer to Data URL.
// 	 * @param {ArrayBuffer} arrayBuffer - The array buffer to transform.
// 	 * @param {string} mimeType - The mime type of the Data URL.
// 	 * @returns {string} The result Data URL.
// 	 */

// 	function arrayBufferToDataURL(arrayBuffer, mimeType) {
// 	  var uint8 = new Uint8Array(arrayBuffer);
// 	  var data = '';

// 	  // TypedArray.prototype.forEach is not supported in some browsers as IE.
// 	  if (typeof uint8.forEach === 'function') {
// 	    uint8.forEach(function (value) {
// 	      data += fromCharCode(value);
// 	    });
// 	  } else {
// 	    var length = uint8.length;


// 	    for (var i = 0; i < length; i += 1) {
// 	      data += fromCharCode(uint8[i]);
// 	    }
// 	  }

// 	  return 'data:' + mimeType + ';base64,' + btoa(data);
// 	}

// 	/**
// 	 * Get orientation value from given array buffer.
// 	 * @param {ArrayBuffer} arrayBuffer - The array buffer to read.
// 	 * @returns {number} The read orientation value.
// 	 */
// 	function getOrientation(arrayBuffer) {
// 	  var dataView = new DataView(arrayBuffer);
// 	  var orientation = void 0;
// 	  var littleEndian = void 0;
// 	  var app1Start = void 0;
// 	  var ifdStart = void 0;

// 	  // Only handle JPEG image (start by 0xFFD8)
// 	  if (dataView.getUint8(0) === 0xFF && dataView.getUint8(1) === 0xD8) {
// 	    var length = dataView.byteLength;
// 	    var offset = 2;

// 	    while (offset < length) {
// 	      if (dataView.getUint8(offset) === 0xFF && dataView.getUint8(offset + 1) === 0xE1) {
// 	        app1Start = offset;
// 	        break;
// 	      }

// 	      offset += 1;
// 	    }
// 	  }

// 	  if (app1Start) {
// 	    var exifIDCode = app1Start + 4;
// 	    var tiffOffset = app1Start + 10;

// 	    if (getStringFromCharCode(dataView, exifIDCode, 4) === 'Exif') {
// 	      var endianness = dataView.getUint16(tiffOffset);

// 	      littleEndian = endianness === 0x4949;

// 	      if (littleEndian || endianness === 0x4D4D /* bigEndian */) {
// 	          if (dataView.getUint16(tiffOffset + 2, littleEndian) === 0x002A) {
// 	            var firstIFDOffset = dataView.getUint32(tiffOffset + 4, littleEndian);

// 	            if (firstIFDOffset >= 0x00000008) {
// 	              ifdStart = tiffOffset + firstIFDOffset;
// 	            }
// 	          }
// 	        }
// 	    }
// 	  }

// 	  if (ifdStart) {
// 	    var _length = dataView.getUint16(ifdStart, littleEndian);
// 	    var _offset = void 0;
// 	    var i = void 0;

// 	    for (i = 0; i < _length; i += 1) {
// 	      _offset = ifdStart + i * 12 + 2;

// 	      if (dataView.getUint16(_offset, littleEndian) === 0x0112 /* Orientation */) {
// 	          // 8 is the offset of the current tag's value
// 	          _offset += 8;

// 	          // Get the original orientation value
// 	          orientation = dataView.getUint16(_offset, littleEndian);

// 	          // Override the orientation with its default value
// 	          dataView.setUint16(_offset, 1, littleEndian);
// 	          break;
// 	        }
// 	    }
// 	  }

// 	  return orientation;
// 	}

// 	/**
// 	 * Parse Exif Orientation value.
// 	 * @param {number} orientation - The orientation to parse.
// 	 * @returns {Object} The parsed result.
// 	 */
// 	function parseOrientation(orientation) {
// 	  var rotate = 0;
// 	  var scaleX = 1;
// 	  var scaleY = 1;

// 	  switch (orientation) {
// 	    // Flip horizontal
// 	    case 2:
// 	      scaleX = -1;
// 	      break;

// 	    // Rotate left 180°
// 	    case 3:
// 	      rotate = -180;
// 	      break;

// 	    // Flip vertical
// 	    case 4:
// 	      scaleY = -1;
// 	      break;

// 	    // Flip vertical and rotate right 90°
// 	    case 5:
// 	      rotate = 90;
// 	      scaleY = -1;
// 	      break;

// 	    // Rotate right 90°
// 	    case 6:
// 	      rotate = 90;
// 	      break;

// 	    // Flip horizontal and rotate right 90°
// 	    case 7:
// 	      rotate = 90;
// 	      scaleX = -1;
// 	      break;

// 	    // Rotate left 90°
// 	    case 8:
// 	      rotate = -90;
// 	      break;

// 	    default:
// 	  }

// 	  return {
// 	    rotate: rotate,
// 	    scaleX: scaleX,
// 	    scaleY: scaleY
// 	  };
// 	}

// 	var REGEXP_DECIMALS = /\.\d*(?:0|9){12}\d*$/i;

// 	/**
// 	 * Normalize decimal number.
// 	 * Check out {@link http://0.30000000000000004.com/}
// 	 * @param {number} value - The value to normalize.
// 	 * @param {number} [times=100000000000] - The times for normalizing.
// 	 * @returns {number} Returns the normalized number.
// 	 */
// 	function normalizeDecimalNumber(value) {
// 	  var times = arguments.length > 1 && arguments[1] !== undefined ? arguments[1] : 100000000000;

// 	  return REGEXP_DECIMALS.test(value) ? Math.round(value * times) / times : value;
// 	}

// 	var classCallCheck = function (instance, Constructor) {
// 	  if (!(instance instanceof Constructor)) {
// 	    throw new TypeError("Cannot call a class as a function");
// 	  }
// 	};

// 	var createClass = function () {
// 	  function defineProperties(target, props) {
// 	    for (var i = 0; i < props.length; i++) {
// 	      var descriptor = props[i];
// 	      descriptor.enumerable = descriptor.enumerable || false;
// 	      descriptor.configurable = true;
// 	      if ("value" in descriptor) descriptor.writable = true;
// 	      Object.defineProperty(target, descriptor.key, descriptor);
// 	    }
// 	  }

// 	  return function (Constructor, protoProps, staticProps) {
// 	    if (protoProps) defineProperties(Constructor.prototype, protoProps);
// 	    if (staticProps) defineProperties(Constructor, staticProps);
// 	    return Constructor;
// 	  };
// 	}();

// 	var _extends = Object.assign || function (target) {
// 	  for (var i = 1; i < arguments.length; i++) {
// 	    var source = arguments[i];

// 	    for (var key in source) {
// 	      if (Object.prototype.hasOwnProperty.call(source, key)) {
// 	        target[key] = source[key];
// 	      }
// 	    }
// 	  }

// 	  return target;
// 	};

// 	var _window$1 = window,
// 	    ArrayBuffer$1 = _window$1.ArrayBuffer,
// 	    FileReader = _window$1.FileReader;

// 	var URL = window.URL || window.webkitURL;
// 	var REGEXP_EXTENSION = /\.\w+$/;

// 	/**
// 	 * Creates a new image compressor.
// 	 * @class
// 	 */

// 	var ImageCompressor = function () {
// 	  /**
// 	   * The constructor of ImageCompressor.
// 	   * @param {File|Blob} file - The target image file for compressing.
// 	   * @param {Object} [options] - The options for compressing.
// 	   */
// 	  function ImageCompressor(file, options) {
// 	    classCallCheck(this, ImageCompressor);

// 	    this.result = null;

// 	    if (file) {
// 	      this.compress(file, options);
// 	    }
// 	  }

// 	  /**
// 	   * The main compress method.
// 	   * @param {File|Blob} file - The target image file for compressing.
// 	   * @param {Object} [options] - The options for compressing.
// 	   * @returns {Promise} - A Promise instance.
// 	   */


// 	  createClass(ImageCompressor, [{
// 	    key: 'compress',
// 	    value: function compress(file, options) {
// 	      var _this = this;

// 	      var image = new Image();

// 	      options = _extends({}, DEFAULTS, options);

// 	      if (!ArrayBuffer$1) {
// 	        options.checkOrientation = false;
// 	      }

// 	      return new Promise(function (resolve, reject) {
// 	        if (!isBlob(file)) {
// 	          reject(new Error('The first argument must be a File or Blob object.'));
// 	          return;
// 	        }

// 	        var mimeType = file.type;

// 	        if (!isImageType(mimeType)) {
// 	          reject(new Error('The first argument must be an image File or Blob object.'));
// 	          return;
// 	        }

// 	        if (!URL && !FileReader) {
// 	          reject(new Error('The current browser does not support image compression.'));
// 	          return;
// 	        }

// 	        if (URL && !options.checkOrientation) {
// 	          resolve({
// 	            url: URL.createObjectURL(file)
// 	          });
// 	        } else if (FileReader) {
// 	          var reader = new FileReader();
// 	          var checkOrientation = options.checkOrientation && mimeType === 'image/jpeg';

// 	          reader.onload = function (_ref) {
// 	            var target = _ref.target;
// 	            var result = target.result;


// 	            resolve(checkOrientation ? _extends({
// 	              url: arrayBufferToDataURL(result, mimeType)
// 	            }, parseOrientation(getOrientation(result))) : {
// 	              url: result
// 	            });
// 	          };
// 	          reader.onabort = function () {
// 	            reject(new Error('Aborted to load the image with FileReader.'));
// 	          };
// 	          reader.onerror = function () {
// 	            reject(new Error('Failed to load the image with FileReader.'));
// 	          };

// 	          if (checkOrientation) {
// 	            reader.readAsArrayBuffer(file);
// 	          } else {
// 	            reader.readAsDataURL(file);
// 	          }
// 	        }
// 	      }).then(function (data) {
// 	        return new Promise(function (resolve, reject) {
// 	          image.onload = function () {
// 	            return resolve(_extends({}, data, {
// 	              naturalWidth: image.naturalWidth,
// 	              naturalHeight: image.naturalHeight
// 	            }));
// 	          };
// 	          image.onabort = function () {
// 	            reject(new Error('Aborted to load the image.'));
// 	          };
// 	          image.onerror = function () {
// 	            reject(new Error('Failed to load the image.'));
// 	          };
// 	          image.alt = file.name;
// 	          image.src = data.url;
// 	        });
// 	      }).then(function (_ref2) {
// 	        var naturalWidth = _ref2.naturalWidth,
// 	            naturalHeight = _ref2.naturalHeight,
// 	            _ref2$rotate = _ref2.rotate,
// 	            rotate = _ref2$rotate === undefined ? 0 : _ref2$rotate,
// 	            _ref2$scaleX = _ref2.scaleX,
// 	            scaleX = _ref2$scaleX === undefined ? 1 : _ref2$scaleX,
// 	            _ref2$scaleY = _ref2.scaleY,
// 	            scaleY = _ref2$scaleY === undefined ? 1 : _ref2$scaleY;
// 	        return new Promise(function (resolve) {
// 	          var canvas = document.createElement('canvas');
// 	          var context = canvas.getContext('2d');
// 	          var aspectRatio = naturalWidth / naturalHeight;
// 	          var maxWidth = Math.max(options.maxWidth, 0) || Infinity;
// 	          var maxHeight = Math.max(options.maxHeight, 0) || Infinity;
// 	          var minWidth = Math.max(options.minWidth, 0) || 0;
// 	          var minHeight = Math.max(options.minHeight, 0) || 0;
// 	          var width = naturalWidth;
// 	          var height = naturalHeight;

// 	          if (maxWidth < Infinity && maxHeight < Infinity) {
// 	            if (maxHeight * aspectRatio > maxWidth) {
// 	              maxHeight = maxWidth / aspectRatio;
// 	            } else {
// 	              maxWidth = maxHeight * aspectRatio;
// 	            }
// 	          } else if (maxWidth < Infinity) {
// 	            maxHeight = maxWidth / aspectRatio;
// 	          } else if (maxHeight < Infinity) {
// 	            maxWidth = maxHeight * aspectRatio;
// 	          }

// 	          if (minWidth > 0 && minHeight > 0) {
// 	            if (minHeight * aspectRatio > minWidth) {
// 	              minHeight = minWidth / aspectRatio;
// 	            } else {
// 	              minWidth = minHeight * aspectRatio;
// 	            }
// 	          } else if (minWidth > 0) {
// 	            minHeight = minWidth / aspectRatio;
// 	          } else if (minHeight > 0) {
// 	            minWidth = minHeight * aspectRatio;
// 	          }

// 	          if (options.width > 0) {
// 	            var _options = options;
// 	            width = _options.width;

// 	            height = width / aspectRatio;
// 	          } else if (options.height > 0) {
// 	            var _options2 = options;
// 	            height = _options2.height;

// 	            width = height * aspectRatio;
// 	          }

// 	          width = Math.min(Math.max(width, minWidth), maxWidth);
// 	          height = Math.min(Math.max(height, minHeight), maxHeight);

// 	          var destX = -width / 2;
// 	          var destY = -height / 2;
// 	          var destWidth = width;
// 	          var destHeight = height;

// 	          if (Math.abs(rotate) % 180 === 90) {
// 	            var _width$height = {
// 	              width: height,
// 	              height: width
// 	            };
// 	            width = _width$height.width;
// 	            height = _width$height.height;
// 	          }

// 	          canvas.width = normalizeDecimalNumber(width);
// 	          canvas.height = normalizeDecimalNumber(height);

// 	          if (!isImageType(options.mimeType)) {
// 	            options.mimeType = file.type;
// 	          }

// 	          var defaultFillStyle = 'transparent';

// 	          // Converts PNG files over the `convertSize` to JPEGs.
// 	          if (file.size > options.convertSize && options.mimeType === 'image/png') {
// 	            defaultFillStyle = '#fff';
// 	            options.mimeType = 'image/jpeg';
// 	          }

// 	          // Override the default fill color (#000, black)
// 	          context.fillStyle = defaultFillStyle;
// 	          context.fillRect(0, 0, width, height);
// 	          context.save();
// 	          context.translate(width / 2, height / 2);
// 	          context.rotate(rotate * Math.PI / 180);
// 	          context.scale(scaleX, scaleY);

// 	          if (options.beforeDraw) {
// 	            options.beforeDraw.call(_this, context, canvas);
// 	          }

// 	          context.drawImage(image, Math.floor(normalizeDecimalNumber(destX)), Math.floor(normalizeDecimalNumber(destY)), Math.floor(normalizeDecimalNumber(destWidth)), Math.floor(normalizeDecimalNumber(destHeight)));

// 	          if (options.drew) {
// 	            options.drew.call(_this, context, canvas);
// 	          }

// 	          context.restore();

// 	          var done = function done(result) {
// 	            resolve({
// 	              naturalWidth: naturalWidth,
// 	              naturalHeight: naturalHeight,
// 	              result: result
// 	            });
// 	          };

// 	          if (canvas.toBlob) {
// 	            canvas.toBlob(done, options.mimeType, options.quality);
// 	          } else {
// 	            done(canvasToBlob(canvas.toDataURL(options.mimeType, options.quality)));
// 	          }
// 	        });
// 	      }).then(function (_ref3) {
// 	        var naturalWidth = _ref3.naturalWidth,
// 	            naturalHeight = _ref3.naturalHeight,
// 	            result = _ref3.result;

// 	        if (URL && !options.checkOrientation) {
// 	          URL.revokeObjectURL(image.src);
// 	        }

// 	        if (result) {
// 	          // Returns original file if the result is greater than it and without size related options
// 	          if (result.size > file.size && options.mimeType === file.type && !(options.width > naturalWidth || options.height > naturalHeight || options.minWidth > naturalWidth || options.minHeight > naturalHeight)) {
// 	            result = file;
// 	          } else {
// 	            var date = new Date();

// 	            result.lastModified = date.getTime();
// 	            result.lastModifiedDate = date;
// 	            result.name = file.name;

// 	            // Convert the extension to match its type
// 	            if (result.name && result.type !== file.type) {
// 	              result.name = result.name.replace(REGEXP_EXTENSION, imageTypeToExtension(result.type));
// 	            }
// 	          }
// 	        } else {
// 	          // Returns original file if the result is null in some cases.
// 	          result = file;
// 	        }

// 	        _this.result = result;

// 	        if (options.success) {
// 	          options.success.call(_this, result);
// 	        }

// 	        return Promise.resolve(result);
// 	      }).catch(function (err) {
// 	        if (!options.error) {
// 	          throw err;
// 	        }

// 	        options.error.call(_this, err);
// 	      });
// 	    }
// 	  }]);
// 	  return ImageCompressor;
// 	}();

// 	return ImageCompressor;

// })));


!function (e, n) { "object" == typeof exports && "undefined" != typeof module ? module.exports = n() : "function" == typeof define && define.amd ? define(n) : (e = e || self).imageCompression = n() }(this, function () { "use strict"; function getDataUrlFromFile(e) { return new Promise(function (n, t) { var r = new FileReader; r.onload = function () { return n(r.result) }, r.onerror = function (e) { return t(e) }, r.readAsDataURL(e) }) } function getFilefromDataUrl(e, n) { var t = arguments.length > 2 && void 0 !== arguments[2] ? arguments[2] : Date.now(); return new Promise(function (r) { for (var i, a = e.split(","), o = a[0].match(/:(.*?);/)[1], s = atob(a[1]), c = s.length, f = new Uint8Array(c); c--;)f[c] = s.charCodeAt(c); try { i = new File([f], n, { type: o }) } catch (e) { (i = new Blob([f], { type: o })).name = n, i.lastModified = t } r(i) }) } function loadImage(e) { return new Promise(function (n, t) { var r = new Image; r.onload = function () { return n(r) }, r.onerror = function (e) { return t(e) }, r.src = e }) } function drawImageInCanvas(e) { var n; return (n = "function" == typeof OffscreenCanvas ? new OffscreenCanvas(e.width, e.height) : document.createElement("canvas")).getContext("2d").drawImage(e, 0, 0, n.width, n.height), n } function drawFileInCanvas(e) { return new Promise(function (n, t) { var r, i, a = function $Try_2_Post() { try { return i = drawImageInCanvas(r), n([r, i]) } catch (e) { return t(e) } }, o = function $Try_2_Catch(n) { try { return getDataUrlFromFile(e).then(function (e) { try { return loadImage(e).then(function (e) { try { return r = e, a() } catch (e) { return t(e) } }, t) } catch (e) { return t(e) } }, t) } catch (e) { return t(e) } }; try { return createImageBitmap(e).then(function (e) { try { return r = e, a() } catch (e) { return o() } }, o) } catch (e) { o() } }) } function canvasToFile(e, n, t, r) { var i = arguments.length > 4 && void 0 !== arguments[4] ? arguments[4] : 1; return new Promise(function (a, o) { var s; return "function" == typeof OffscreenCanvas && e instanceof OffscreenCanvas ? e.convertToBlob({ type: n, quality: i }).then(function (e) { try { return (s = e).name = t, s.lastModified = r, $If_4.call(this) } catch (e) { return o(e) } }.bind(this), o) : getFilefromDataUrl(e.toDataURL(n, i), t, r).then(function (e) { try { return s = e, $If_4.call(this) } catch (e) { return o(e) } }.bind(this), o); function $If_4() { return a(s) } }) } function getExifOrientation(e) { return new Promise(function (n, t) { var r = new FileReader; r.onload = function (e) { var t = new DataView(e.target.result); if (65496 != t.getUint16(0, !1)) return n(-2); for (var r = t.byteLength, i = 2; i < r;) { if (t.getUint16(i + 2, !1) <= 8) return n(-1); var a = t.getUint16(i, !1); if (i += 2, 65505 == a) { if (1165519206 != t.getUint32(i += 2, !1)) return n(-1); var o = 18761 == t.getUint16(i += 6, !1); i += t.getUint32(i + 4, o); var s = t.getUint16(i, o); i += 2; for (var c = 0; c < s; c++)if (274 == t.getUint16(i + 12 * c, o)) return n(t.getUint16(i + 12 * c + 8, o)) } else { if (65280 != (65280 & a)) break; i += t.getUint16(i, !1) } } return n(-1) }, r.onerror = function (e) { return t(e) }, r.readAsArrayBuffer(e) }) } function handleMaxWidthOrHeight(e, n, t) { var r = n.getContext("2d"), i = t.maxWidthOrHeight, a = Number.isInteger(i) && (e.width > i || e.height > i); return a ? e.width > e.height ? (n.width = i, n.height = e.height / e.width * i) : (n.width = e.width / e.height * i, n.height = i) : (n.width = e.width, n.height = e.height), r.drawImage(e, 0, 0, n.width, n.height), [n, a] } function followExifOrientation(e, n, t) { var r = n.getContext("2d"), i = e.width, a = e.height; switch (4 < t && t < 9 ? (n.width = a, n.height = i) : (n.width = i, n.height = a), t) { case 2: r.transform(-1, 0, 0, 1, i, 0); break; case 3: r.transform(-1, 0, 0, -1, i, a); break; case 4: r.transform(1, 0, 0, -1, 0, a); break; case 5: r.transform(0, 1, 1, 0, 0, 0); break; case 6: r.transform(0, 1, -1, 0, a, 0); break; case 7: r.transform(0, -1, -1, 0, a, i); break; case 8: r.transform(0, -1, 1, 0, 0, i) }return r.drawImage(e, 0, 0), n } function compress(e, n) { return new Promise(function (t, r) { var i, a, o, s, c, f, u, m, l; return i = n.maxIteration || 10, a = 1024 * n.maxSizeMB * 1024, e.size <= a && void 0 === n.maxWidthOrHeight ? t(e) : drawFileInCanvas(e).then(function (h) { try { return o = (f = h)[0], s = f[1], u = handleMaxWidthOrHeight(o, s, n), s = u[0], c = u[1], e.size <= a && !c ? t(e) : new Promise(function (t, r) { var i; if (!(i = n.exifOrientation)) return getExifOrientation(e).then(function (e) { try { return i = e, $If_2.call(this) } catch (e) { return r(e) } }.bind(this), r); function $If_2() { return t(i) } return $If_2.call(this) }).then(function (c) { try { return n.exifOrientation = c, s = followExifOrientation(o, s, n.exifOrientation), m = 1, canvasToFile(s, e.type, e.name, e.lastModified, m).then(function (n) { try { var c = function $If_3() { return t(l) }; if (l = n, "image/png" === e.type) { var f, u = function $Loop_4() { return i-- && l.size > a ? (s.width *= .9, s.height *= .9, s.getContext("2d").drawImage(o, 0, 0, s.width, s.height), canvasToFile(s, e.type, e.name, e.lastModified, m).then(function (e) { try { return l = e, $Loop_4 } catch (e) { return r(e) } }, r)) : [1] }, h = function $Loop_4_exit() { return c.call(this) }; return (f = function (e) { for (; e;) { if (e.then) return void e.then(f, r); try { if (e.pop) { if (e.length) return e.pop() ? h.call(this) : e; e = u } else e = e.call(this) } catch (e) { return r(e) } } }.bind(this))(u) } var g, d = function $Loop_6() { return i-- && l.size > a ? (s.width *= .9, s.height *= .9, s.getContext("2d").drawImage(o, 0, 0, s.width, s.height), m *= .9, canvasToFile(s, e.type, e.name, e.lastModified, m).then(function (e) { try { return l = e, $Loop_6 } catch (e) { return r(e) } }, r)) : [1] }, p = function $Loop_6_exit() { return c.call(this) }; return (g = function (e) { for (; e;) { if (e.then) return void e.then(g, r); try { if (e.pop) { if (e.length) return e.pop() ? p.call(this) : e; e = d } else e = e.call(this) } catch (e) { return r(e) } } }.bind(this))(d) } catch (e) { return r(e) } }.bind(this), r) } catch (e) { return r(e) } }.bind(this), r) } catch (e) { return r(e) } }.bind(this), r) }) } var e, n = 0; var t = function createWorker(e) { return new Worker(URL.createObjectURL(new Blob(["(".concat(e, ")()")]))) }(function () { self.addEventListener("message", function (e) { return new Promise(function (n, t) { var r, i, a, o, s = e.data; r = s.file, i = s.id, a = s.imageCompressionLibUrl, o = s.options; var c = function $Try_1_Post() { try { return n() } catch (e) { return t(e) } }, f = function $Try_1_Catch(e) { try { return self.postMessage({ error: e.message, id: i }), c() } catch (e) { return t(e) } }; try { var u; return importScripts(a), imageCompression(r, o).then(function (e) { try { return u = e, self.postMessage({ file: u, id: i }), c() } catch (e) { return f(e) } }, f) } catch (e) { f(e) } }) }) }); function compressOnWebWorker(r, i) { return new Promise(function (a, o) { return new Promise(function (s, c) { e || (e = function createSourceObject(e) { return URL.createObjectURL(new Blob([e], { type: "application/javascript" })) }("\n    function imageCompression (){return (".concat(imageCompression, ").apply(null, arguments)}\n    \n    imageCompression.getDataUrlFromFile = ").concat(imageCompression.getDataUrlFromFile, "\n    imageCompression.getFilefromDataUrl = ").concat(imageCompression.getFilefromDataUrl, "\n    imageCompression.loadImage = ").concat(imageCompression.loadImage, "\n    imageCompression.drawImageInCanvas = ").concat(imageCompression.drawImageInCanvas, "\n    imageCompression.drawFileInCanvas = ").concat(imageCompression.drawFileInCanvas, "\n    imageCompression.canvasToFile = ").concat(imageCompression.canvasToFile, "\n    imageCompression.getExifOrientation = ").concat(imageCompression.getExifOrientation, "\n    imageCompression.handleMaxWidthOrHeight = ").concat(imageCompression.handleMaxWidthOrHeight, "\n    imageCompression.followExifOrientation = ").concat(imageCompression.followExifOrientation, "\n    \n    getDataUrlFromFile = imageCompression.getDataUrlFromFile\n    getFilefromDataUrl = imageCompression.getFilefromDataUrl\n    loadImage = imageCompression.loadImage\n    drawImageInCanvas = imageCompression.drawImageInCanvas\n    drawFileInCanvas = imageCompression.drawFileInCanvas\n    canvasToFile = imageCompression.canvasToFile\n    getExifOrientation = imageCompression.getExifOrientation\n    handleMaxWidthOrHeight = imageCompression.handleMaxWidthOrHeight\n    followExifOrientation = imageCompression.followExifOrientation\n\n    function compress (){return (").concat(compress, ").apply(null, arguments)}\n    "))); var f = n++; return t.addEventListener("message", function handler(e) { e.data.id === f && (t.removeEventListener("message", handler), e.data.error && o(e.data.error), a(e.data.file)) }), t.postMessage({ file: r, id: f, imageCompressionLibUrl: e, options: i }), s() }) }) } function imageCompression(e, n) { return new Promise(function (t, r) { var i, a; if (n.maxSizeMB = n.maxSizeMB || Number.POSITIVE_INFINITY, n.useWebWorker = "boolean" != typeof n.useWebWorker || n.useWebWorker, !(e instanceof Blob || e instanceof File)) return r(new Error("The file given is not an instance of Blob or File")); if (!/^image/.test(e.type)) return r(new Error("The file given is not an image")); if (a = "undefined" != typeof WorkerGlobalScope && self instanceof WorkerGlobalScope, !n.useWebWorker || "function" != typeof Worker || a) return compress(e, n).then(function (e) { try { return i = e, $If_3.call(this) } catch (e) { return r(e) } }.bind(this), r); var o = function () { try { return $If_3.call(this) } catch (e) { return r(e) } }.bind(this), s = function $Try_1_Catch(t) { try { return compress(e, n).then(function (e) { try { return i = e, o() } catch (e) { return r(e) } }, r) } catch (e) { return r(e) } }; try { return compressOnWebWorker(e, n).then(function (e) { try { return i = e, o() } catch (e) { return s() } }, s) } catch (e) { s() } function $If_3() { try { i.name = e.name, i.lastModified = e.lastModified } catch (e) { } return t(i) } }) } return imageCompression.getDataUrlFromFile = getDataUrlFromFile, imageCompression.getFilefromDataUrl = getFilefromDataUrl, imageCompression.loadImage = loadImage, imageCompression.drawImageInCanvas = drawImageInCanvas, imageCompression.drawFileInCanvas = drawFileInCanvas, imageCompression.canvasToFile = canvasToFile, imageCompression.getExifOrientation = getExifOrientation, imageCompression.handleMaxWidthOrHeight = handleMaxWidthOrHeight, imageCompression.followExifOrientation = followExifOrientation, imageCompression });
//# sourceMappingURL=browser-image-compression.js.map