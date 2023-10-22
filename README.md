##  계산기

---
### 🔎 목차
- [팀원](#-팀원)
- [타임라인](#-타임라인)
- [시각화 구조](#-시각화-구조)
- [실행화면](#-실행화면)
- [트러블 슈팅](#-트러블-슈팅)
- [참고 링크](#-참고-링크)

---
### 👥 팀원
|Kiseok|Hisop|
|---|---|
|[GitHub](https://github.com/carti1108)|[GitHub](https://github.com/Hi-sop/ios-calculator-app)

### 📅 타임라인
|날짜|내용|
|------|---|
|23.10.16| - Merge계획 수립 및 개인 코드 정리 |
|23.10.17|- 계산기 코드 병합 및 PR |
|23.10.18|- 피드백 요구 사항 반영 |
|23.10.19|- 계산기 코드 리팩터링 및 PR |
|23.10.20|- README 작성|


### 👀 시각화 구조
#### Class Diagram
![632a7061324ce85b6f34ebd5](https://github.com/yagom-academy/ios-calculator-app/assets/69287436/7e1e43dd-2ff8-4517-b48e-c6cdc1886ad2) 

### 🖥️ 실행화면

<img src="https://github.com/yagom-academy/ios-calculator-app/assets/69287436/7dcecd35-8403-4882-a6fd-233f676ae537" width="300" height="575"/>


### 🔥 트러블 슈팅

#### Queue의 자료구조 선택

- 더블스택 채택
    - 시간복잡도 면에서 LinkedList와 차이가 없으며, 배열 구조로 유닛 테스트환경에서 임의의 값을 넣어주기 편하고, 구조가 단순하여 이해해기 좋다는 장점이 있어 채택하게 됨

#### 연산 결과 부동소수점 오류 

- 소수점 연산 시 부동 소수점 오류 때문에 제대로된 연산값이 나오지 않는 경우가 발생함<br>
 연산 결과값에 numberFormatter를 사용하여 해결함
 ```swift
func numberFormatter() -> String {
        let numberFormatter = NumberFormatter()
        numberFormatter.numberStyle = .decimal
        numberFormatter.maximumFractionDigits = 20
        
        return numberFormatter.string(for: Double(self)) ?? ""
    }
// 9x1.2 연산을 했을 때 10.79999999...가 나오던 오류를 10.8로 고쳐줌
```

#### ScrollView 화면 자동으로 하단 이동 구현
- 스크롤뷰에 스택 추가 할 때마다 스크롤뷰 밑으로 이동 구현
스택뷰를 추가할 때마다 offset값을 이용하여 맨 밑으로 이동하는 로직을 구현하였으나 바닥까지 내려가지 않음<br>
-> offset값을 구하는 순간에 추가된 스택뷰를 포함하여 계산되지 않아 생긴 문제<br>
-> layoutIfNeeded 메서드를 사용하여 뷰 드로잉 사이클을 기다리지 않고 즉시 실행되도록 변경함
```swift
private func scrollToBottom() {
        formulaScrollView.layoutIfNeeded()
        formulaScrollView.setContentOffset(CGPoint(x: 0, y: formulaScrollView.contentSize.height - formulaScrollView.bounds.height), animated: false)
    }
```


### 📚 참고 링크
[Apple 공식문서 - Array](https://developer.apple.com/documentation/swift/array)<br>
[Apple 공식문서 - reversed](https://developer.apple.com/documentation/swift/array/reversed())<br>
[Apple 공식문서 - UIStackView](https://developer.apple.com/documentation/uikit/uistackview)<br>
[Apple 공식문서 - Auto Layout](https://developer.apple.com/library/archive/documentation/UserExperience/Conceptual/AutolayoutPG/index.html)<br>
[Apple 공식문서 - XCTest](https://developer.apple.com/documentation/xctest)<br>
[Apple 공식문서 - NumberFormatter](https://developer.apple.com/documentation/foundation/numberformatter)<br>
[Apple 공식문서 - Split](https://developer.apple.com/documentation/swift/string/split(separator:maxsplits:omittingemptysubsequences:))<br>
[Apple 공식문서 - removeArrangedSubview](https://developer.apple.com/documentation/uikit/uistackview/1616235-removearrangedsubview)<br>
[Apple 공식문서 - UILabel](https://developer.apple.com/documentation/uikit/uilabel)<br>
[Apple 공식문서 - IntrinsicContentSize](https://developer.apple.com/documentation/uikit/uiview/1622600-intrinsiccontentsize)

---
