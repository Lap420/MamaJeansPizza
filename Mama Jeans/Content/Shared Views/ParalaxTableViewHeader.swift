import UIKit

class ParalaxTableView: UITableView {
    override func layoutSubviews() {
        super.layoutSubviews()
        guard let header = tableHeaderView else { return }
        guard let headerImageView = header.subviews.first as? UIImageView else { return }
        let offsetY = -contentOffset.y
        let height = max(header.bounds.height, header.bounds.height + offsetY)
        let bottom = offsetY >= 0 ? 0 : offsetY / 2
        headerImageView.snp.removeConstraints()
        headerImageView.snp.makeConstraints { make in
            make.height.equalTo(height)
            make.leading.trailing.equalToSuperview()
            make.bottom.equalToSuperview().inset(bottom)
        }
        header.clipsToBounds = offsetY <= 0
        headerImageView.alpha = 1 - (-offsetY / 400)
    }
}
